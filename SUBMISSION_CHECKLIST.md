# Phase 0 submission checklist — INSY 8311

## Completed / prepared
- [x] Project topic, problem statement and objectives drafted.
- [x] Public GitHub repository created.
- [x] README includes problem, objectives, dataset, innovation, planned tables, PL/SQL features and references.
- [x] Research log contains eight source entries covering two research papers, an academic dissertation, an existing official statistical system, the primary dataset, a government report, a supplementary dataset and technical documentation.
- [x] NISR SAS 2024 archive inspected: 12 CSVs across Seasons A, B and C.
- [x] Crop_Production row counts recorded: Season A 39,330; Season B 35,584; Season C 1,949; total 76,863.
- [x] Database design and ERD added.
- [x] Oracle DDL, staging design, PL/SQL starter and analytical queries added.
- [x] Two-page proposal DOCX prepared; page count checked as 2.
- [x] Twelve-slide PowerPoint prepared.

## Still required before Phase 0 submission
- [ ] Check the class registration sheet and register the topic with a 2–3 sentence description. If the instructor considers the idea too close to an earlier entry, obtain guidance before finalizing.
- [ ] Student reads the two cited research papers and the MINAGRI report before the defence.
- [ ] Confirm the final PowerPoint includes a few anonymized sample records from the actual dataset.
- [ ] Upload the final PowerPoint file to this GitHub repository (the slide outline is already committed).
- [ ] Email the two-page proposal and GitHub link to eric.maniraguha@auca.ac.rw.
- [ ] Confirm the lecturer's preferred upload/registration procedure and AI-use policy.

## Technical cautions for later project phases
- SQL scripts are starter implementation and have not been tested in Oracle.
- Keep raw CSVs and SAS2024_Data_Dictionary.xlsx as source evidence; check privacy and any item-specific licence before publishing raw records.
- Do not silently map 9999 to NULL or remove negative loss values; confirm questionnaire codes first.
- Utilization and loss records are farmer-crop grain; do not sum repeated values across plot rows.
- Do not claim national weighted estimates until NISR's weighting methodology is confirmed.
- The innovation must connect to the live Oracle database; static mock-ups do not satisfy the final 8-mark innovation criterion.

## Links
- Repository: https://github.com/ishimwekevin1/kevin_20251SEN015_cropMonitor
- Topic registration: https://docs.google.com/spreadsheets/d/1_1qbX-viAAwHAzxWR6G_f31yzB6ks7sV1-HgwAgbdVA/edit?usp=sharing
- NISR collection: https://data.gov.rw/collections/360cab66-ac0e-4aa0-9c5e-43c052d0bf0a
- Lecturer: eric.maniraguha@auca.ac.rw

**Phase 0 deadline shown on the assignment sheet:** 13 November 2026, 2:00 PM.
