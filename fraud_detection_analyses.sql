-- ==========================================================
-- PROJECT: Markt Anomalie & Fraude Detectie
-- DOEL: Berekenen van Z-scores en markeren van uitschieters
-- ==========================================================

-- 1. DATA OPSCHONEN
-- We zetten lege cellen om naar echte NULL-waarden voor juiste berekeningen.
UPDATE Fraude_Detectie_Output 
SET Z_score = NULL 
WHERE Z_score = '' OR Z_score = ' ';

-- 2. ANALYSE MET AUTOMATISCHE DETECTIE
-- We berekenen het gemiddelde en de afwijking (Z-score) live op de data.
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
    -- Afronden op 4 decimalen voor een professionele look
    ROUND((Log_Returns - Stats.Gemiddelde) / Stats.StandaardDeviatie, 4) AS Berekende_Z_Score,
    -- Markeer alles boven de 2.0 of onder de -2.0 als anomalie
    CASE 
        WHEN ABS((Log_Returns - Stats.Gemiddelde) / Stats.StandaardDeviatie) > 2.0 THEN '⚠️ ANOMALIE'
        ELSE 'Normaal'
    END AS Status_Detectie
FROM Fraude_Detectie_Output, Stats
WHERE Log_Returns IS NOT NULL
ORDER BY ABS(Berekende_Z_Score) DESC;