📈 Market Anomaly & Fraud Detection (SQL)
Projectomschrijving
In dit project heb ik een robuust systeem ontwikkeld in SQL (SQLite) om ongebruikelijke marktactiviteiten en potentiële fraude te detecteren in financiële data. In plaats van te vertrouwen op handmatige checks, heb ik een statistisch model (Z-score) direct in de database-laag gebouwd.
🛠️ Gebruikte Technieken
Database: SQLite via DBeaver.
SQL-concepten:
CTEs (Common Table Expressions): Voor een modulaire en leesbare codestructuur.
Data Cleaning: Omzetten van lege strings naar NULL voor betrouwbare statistieken.
Statistische Functies: Berekenen van het gemiddelde en de standaarddeviatie binnen SQLite.
Automatisering: Gebruik van CASE statements voor het automatisch vlaggen van anomalieën.