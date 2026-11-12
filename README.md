# Rwanda Crop Production and Post-Harvest Loss Monitoring System

**Student:** ISHIMWE Kevin — **Student ID:** 20251SEN015  
**Course:** INSY 8311 — Database Development with PL/SQL  
**Instructor:** Eric Maniraguha

## Problem statement
Agricultural planning depends on reliable information about crop production, utilization and losses. Rwanda's Seasonal Agricultural Survey (SAS) provides detailed records across crops, seasons and districts, but the data must be modelled carefully. Farmer-crop utilization and reported loss values can repeat across plot rows; aggregating them at the wrong grain can double-count quantities.

## Objectives
1. Build a normalized Oracle database for seasonal crop production, plot harvest, utilization and reported loss records.
2. Validate and load the public NISR SAS 2024 data while preserving source traceability and rejected-row evidence.
3. Compare descriptive production, utilization and pre-/post-harvest loss indicators by crop, season and district.
4. Implement PL/SQL packages, procedures, functions, explicit cursors, triggers and exception handling.
5. Deliver an interactive dashboard connected to the live Oracle database.

## Data source
National Institute of Statistics of Rwanda (NISR), *Rwanda Seasonal Agricultural Survey 2024* (agricultural year 2023/2024). The Data Sharing Platform collection contains 12 public CSV datasets: Crop Production, Household Screening, Agricultural Practices, and Fertilizer and Pesticide Use for Seasons A, B and C. The inspected archive's Crop_Production tables contain 39,330 Season A rows, 35,584 Season B rows and 1,949 Season C rows (76,863 total). The inspection also reported 83 crop names, 21 categories, five provinces and 30 districts.

- Collection: https://data.gov.rw/collections/360cab66-ac0e-4aa0-9c5e-43c052d0bf0a
- Dataset page: https://data.gov.rw/datasets/f1fe0aa2-fbb5-4945-a4d7-796cd3703d00
- NISR terms of use: https://www.statistics.gov.rw/terms-use (CC BY 4.0 unless a dataset states otherwise; acknowledge NISR and preserve data integrity).

## Database design
The schema separates reference entities and facts: SEASON, GEOGRAPHIC_AREA, STRATUM, FARM_TYPE, CROP_CATEGORY, CROP, FARM_UNIT, PLOT, PRODUCTION_RECORD, PLOT_CROP, USE_TYPE, UTILIZATION, LOSS_TYPE, LOSS_RECORD, IMPORT_BATCH and IMPORT_REJECT.

**Grain rule:** FARM_UNIT is unique within season by sampling segment and farmer ID. PLOT_CROP stores plot-crop harvest. PRODUCTION_RECORD stores farmer-crop values. UTILIZATION and LOSS_RECORD reference PRODUCTION_RECORD so farmer-crop values are not multiplied by the number of plots. The s2q39 reported-loss measure remains separate from the s2q41–s2q50 cause breakdown.

## Planned PL/SQL features
- IMPORT_PKG: validate staged records and log rejected source rows.
- LOSS_PKG: calculate explicitly defined descriptive loss indicators with zero-denominator handling.
- REPORT_PKG: produce crop, district and seasonal summaries.
- Explicit cursors: process staged batches in a controlled manner.
- Triggers: audit selected data changes and enforce business restrictions.
- Exceptions: handle invalid references, duplicate records and invalid quantities.

## Innovation
A Streamlit dashboard connected to the live Oracle database using python-oracledb. It will provide crop, season and district filters, descriptive KPIs and separate pre-/post-harvest loss charts. Business rules remain in PL/SQL; static mock-ups do not satisfy the project requirement.

## Limitations and data-quality rules
This is a survey sample, not a census. Season C has fewer observations. Do not present unweighted sample sums as national estimates. Confirm questionnaire codes before recoding values such as 9999 or removing negative observations. Do not join plot weights to farmer-crop utilization/loss totals without confirming NISR's estimation methodology. Source records and transformations must remain traceable.

## Repository structure
- `docs/proposal/` — proposal
- `docs/research/` — research log and source notes
- `docs/database/` — database design and ERD
- `docs/presentation/` — presentation outline
- `sql/` — Oracle DDL, staging, PL/SQL starter and analytical queries
- `SUBMISSION_CHECKLIST.md` — Phase 0 submission actions

## Selected references
- Austin, K. G., et al. (2020). Impacts of climate change on the potential productivity of eleven staple crops in Rwanda. *Sustainability, 12*(10), 4116. https://doi.org/10.3390/su12104116
- Ntabakirabose, G., et al. (2021). Analysis of the factors influencing maize postharvest losses and effect of agricultural inputs supply on productivity in Rwanda: A case of Gatsibo and Nyagatare. *American Journal of Management Science and Engineering, 6*(6), 203–212. https://doi.org/10.11648/j.ajmse.20210606.14
- Ministry of Agriculture and Animal Resources. (2025). *Annual report 2023–2024*. https://www.minagri.gov.rw/fileadmin/user_upload/Minagri/Publications/Annual_Reports/MINAGRI_Annual_Report_for_2023-24_FY__FINAL.pdf
- National Institute of Statistics of Rwanda. (2024). *Rwanda Seasonal Agricultural Survey 2024* [Dataset]. https://data.gov.rw/collections/360cab66-ac0e-4aa0-9c5e-43c052d0bf0a
- Oracle. (2021). *Oracle Database 21c: Coding PL/SQL subprograms and packages*. https://docs.oracle.com/en/database/oracle/oracle-database/21/adfns/coding-subprograms-and-packages.html
