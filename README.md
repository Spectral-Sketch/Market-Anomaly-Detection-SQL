# 📈 Market Anomaly & Fraud Detection (SQL)

## Projectomschrijving
In dit project heb ik een robuust systeem ontwikkeld in **SQL (SQLite)** om ongebruikelijke marktactiviteiten en potentiële fraude te detecteren. In plaats van handmatige controles heb ik een statistisch model (Z-score) direct in de database-laag gebouwd.

## 🛠️ Gebruikte Technieken
* **Database:** SQLite via DBeaver.
* **SQL-concepten:** 
    * **CTEs (Common Table Expressions):** Voor een modulaire structuur.
    * **Data Cleaning:** Omzetten van lege strings naar `NULL`.
    * **Statistische Functies:** Berekenen van gemiddelde en standaarddeviatie.
    * **Automatisering:** Gebruik van `CASE`-statements voor het vlaggen van anomalieën.

## 📊 Hoe het werkt
De kern van de analyse is de **Z-score**. Deze vertelt ons hoeveel een waarde afwijkt van het gemiddelde. Alles buiten de +/- 2.0 grens wordt automatisch gemarkeerd als `⚠️ ANOMALIE`.
