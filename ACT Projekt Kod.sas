/* Ustawienie odpowiedniej œcie¿ki, poprzez stworzenie nowej biblioteki */
libname projekt "C:\Users\Micha³ J\Desktop\SGH\ACT\Projekt\";
title;
/*Wczytywanie odpowiedniego zbioru*/

proc import datafile="C:\Users\Micha³ J\Desktop\SGH\ACT\Projekt\heart_transplant.csv"
    out=projekt.heart_transplant
    dbms=csv
    replace;
    getnames=yes;
run;

/* Podgl¹d danych*/
proc contents data=projekt.heart_transplant;
run;
proc print data=projekt.heart_transplant(obs=103);
run;

/*Przekszta³cenie zmiennych kategorycznych na binarne*/
data projekt.heart_clean;
    set projekt.heart_transplant;

    status         = (strip(lowcase(survived)) = "dead");			/* 1 = dead, 0 = alive */
    transplant_bin = (strip(lowcase(transplant)) = "treatment");	/* 1 = treatment, 0 = control */
    prior_bin      = (strip(lowcase(prior)) = "ye");				/* 1 = prior surgery, 0 = no */
run;

/* Podgl¹d danych*/
proc contents data=projekt.heart_clean;
run;
proc print data=projekt.heart_clean(obs=10);
run;

/* Sprawdzam nowo wporadzone zmienne*/
proc freq data=projekt.heart_clean;
    tables status transplant_bin prior_bin;
run;

/* Pozbywam siê niepotrzebnych zmiennych ze zbioru*/
data projekt.heart_final;
    set projekt.heart_clean(keep=id acceptyear age survtime wait 
                            status transplant_bin prior_bin);
run;

/* Podgl¹d danych*/
proc contents data=projekt.heart_final;
run;
proc print data=projekt.heart_final(obs=10);
run;
/*
Zmienne które pozosta³yw  zbiorze:

id, acceptyear– informacja pomocnicza

age, survtime, wait –  predyktory

status – zmienna zale¿na (zgon "1")

transplant_bin, prior_bin – zakodowane predyktory
*/

/*Statystyki opisowe zmiennych*/
title "Statystyki opisowe zmiennych";
proc means data=projekt.heart_final n mean std min p25 median p75 max maxdec=1;
    var age survtime;
run;

proc freq data=projekt.heart_final;
    tables status transplant_bin prior_bin / nocum norow nocol nopercent;
run;

/* Model nieparametryczny */

ods graphics on;

/* Kaplan-Meier – ogólnie */
title "Kaplan-Meier: Ogólna funkcja prze¿ycia";
proc lifetest data=projekt.heart_final plots=s;
    time survtime*status(0);
run;

/* Kaplan-Meier z funkcj¹ prze¿ycia i hazardu (metoda LIFE) */
title "Kaplan-Meier: Metoda LIFE – prze¿ycie i hazard";
proc lifetest data=projekt.heart_final method=life plots=(s h);
    time survtime*status(0);
run;

/* Kaplan-Meier z podzia³em na grupy (transplant_bin, prior_bin) */
title "Kaplan-Meier: Funkcja prze¿ycia wg transplant_bin i prior_bin";
proc lifetest data=projekt.heart_final plots=s;
    time survtime*status(0);
    strata transplant_bin prior_bin / adjust=tukey;
run;

/* Testowanie zmiennych (log-rank test) */
title "Kaplan-Meier: Log-rank test zmiennych";
proc lifetest data=projekt.heart_final plots=s;
    time survtime*status(0);
    test transplant_bin prior_bin age;
run;

ods graphics off;
title;

