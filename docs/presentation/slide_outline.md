# Phase 0 presentation — 12 slides

1. **Title:** Project title, ISHIMWE Kevin, 20251SEN015, INSY 8311, instructor and GitHub link.
2. **Background/problem:** seasonal agricultural records require careful integration; repeated farmer-crop totals can be double-counted.
3. **Motivation:** make public Rwanda survey data easier to explore by crop, season, district, utilization and loss cause.
4. **Objectives:** normalize survey data in Oracle; compare production; analyze utilization and pre-/post-harvest losses; build a live dashboard.
5. **Research/gap:** Rwanda crop/climate studies, NISR survey and FAOSTAT provide research and data; project focuses on normalized database and interactive exploration.
6. **Data:** NISR SAS 2024, 12 CSVs. Crop_Production: Season A 39,330, B 35,584, C 1,949; total 76,863. 83 crop names, 21 categories, 5 provinces, 30 districts. Include dataset URL.
7. **Solution/innovation:** Oracle + PL/SQL + Streamlit connected to live Oracle using python-oracledb.
8. **Database:** Season, Geography, Stratum, Farm Type, Crop Category, Crop, Farm Unit, Plot, Production Record, Plot Crop, Utilization, Loss Type, Loss Record, Import Batch and Reject. Show ERD.
9. **PL/SQL:** IMPORT_PKG validates and logs rejects; LOSS_PKG calculates defined descriptive indicators; REPORT_PKG creates summaries; cursor processes batches; trigger audits; exceptions handle invalid data.
10. **Expected results:** normalized database, controlled imports, crop/season/district summaries, utilization/loss analysis and live dashboard.
11. **Limitations/future work:** survey sample not census; smaller Season C; geography limited; loss measures differ; validate weighting; future weather integration.
12. **References:** verified APA sources from docs/research/research_log.md; remove unverified citations.