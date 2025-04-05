# 📊 Analiza przeżycia – Heart Transplant Study

## 🧠 Temat projektu
**Wpływ przeszczepu serca na przeżycie pacjentów zakwalifikowanych do programu transplantacyjnego.**

Projekt oparty na danych ze Stanford Heart Transplant Study, obejmujących 103 pacjentów w ciężkim stanie, zakwalifikowanych do przeszczepu serca.

---

## 🎯 Cel projektu
Celem całego projektu jest analiza czynników wpływających na długość życia pacjentów oczekujących na przeszczep serca. Analiza do tej pory obejmuje:
- wpływ przeszczepienia serca (`transplant_bin`),
- wcześniejsze interwencje medyczne (`prior_bin`),
- wiek pacjenta (`age`).

W projekcie do tej pory zastosowano metody nieparametryczne (Kaplan-Meier, testy log-rank).

---

## 👤 Moja część projektu

Zakres mojej odpowiedzialności w projekcie:
1. Sformułowanie tematu i celu projektu.
2. Przygotowanie **opisu danych** – charakterystyka zmiennych, rozkłady i statystyki opisowe.
3. **Analiza nieparametryczna czasu przeżycia**:
   - estymacja funkcji przeżycia metodą Kaplana-Meiera,
   - analiza funkcji hazardu (metoda LIFE),
   - porównanie krzywych przeżycia między grupami (`transplant_bin`, `prior_bin`),
   - testy istotności (log-rank, Wilcoxon) dla zmiennych wpływających na czas przeżycia.

---

## 📈 Narzędzia i metody

- SAS 9.4 – PROC LIFETEST, metoda Kaplan-Meiera i metoda LIFE
- Krzywe przeżycia i hazardu
- Testy log-rank i Wilcoxon dla zmiennych dyskretnych i ciągłych
- Analiza rozkładów zmiennych (`proc means`, `proc freq`)

---

## 📌 Wnioski z analizy nieparametrycznej

- **Przeszczepienie serca istotnie wydłuża czas przeżycia** – mediana wzrasta z 21 do 207 dni.
- `prior_bin` (wcześniejsza interwencja) występuje tylko w grupie przeszczepionej → wymaga ostrożnej interpretacji.
- Wiek pacjenta ma istotny wpływ na przeżycie (p ~0.03).
- Najwyższy hazard zgonu występuje w pierwszych tygodniach od kwalifikacji (jednak ilość obserwacji nie jest wielka i występują okresy gdzie hazard = 0, przez co tradycyjne tablice trwania życia nie są idealne).

---
## Miłej pracy :-)
---
## 📬 Kontakt

Autor części nieparametrycznej: **Michał Jamroży**  
📧 [mj113984@student.sgh.waw.pl]  
💼 Student Analiza Danych - Big Data, SGH  
