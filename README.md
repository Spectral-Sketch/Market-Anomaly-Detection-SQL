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


## 💻 SQL-Code Voorbeeld
Hieronder een fragment van de core-logica waarbij ik gebruikmaak van een **Common Table Expression (CTE)** om de Z-scores te berekenen en uitschieters te markeren:

```sql
WITH Stats AS (
    SELECT 
        AVG(Log_Returns) AS Gemiddelde,
        SQRT(AVG(Log_Returns * Log_Returns) - AVG(Log_Returns) * AVG(Log_Returns)) AS StandaardDeviatie
    FROM Fraude_Detectie_Output
    WHERE Log_Returns IS NOT NULL
)
SELECT 
    Date,
    Log_Returns,
    ROUND((Log_Returns - Stats.Gemiddelde) / Stats.StandaardDeviatie, 4) AS Berekende_Z_Score,
    CASE 
        WHEN ABS((Log_Returns - Stats.Gemiddelde) / Stats.StandaardDeviatie) > 2.0 THEN '⚠️ ANOMALIE'
        ELSE 'Normaal'
    END AS Status_Detectie
FROM Fraude_Detectie_Output, Stats
ORDER BY ABS(Berekende_Z_Score) DESC;
