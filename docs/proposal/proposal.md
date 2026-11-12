# Rwanda Crop Production and Post-Harvest Loss Monitoring System

**Student:** ISHIMWE Kevin | **ID:** 20251SEN015  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Instructor:** Eric Maniraguha

## Problem Statement
Agricultural planning requires reliable information about crop production, utilization and losses. Rwanda's Seasonal Agricultural Survey provides detailed seasonal records, but analysis requires careful integration of crop, plot, farmer, location and season information. Utilization and loss values repeat at farmer-crop level across plot rows, so careless aggregation can double-count them. This project addresses this data-management problem through a normalized Oracle database and an interactive reporting interface.

## Proposed Solution
Develop an Oracle database application to organize seasonal crop production, plot harvest, utilization and reported loss causes. Users will compare crops, seasons and districts and distinguish pre-harvest from post-harvest loss categories. PL/SQL packages will support validation, reporting and audit logging. This is an educational analytical prototype, not an official NISR statistical estimation system.

## Data Source
Primary source: National Institute of Statistics of Rwanda, *Rwanda Seasonal Agricultural Survey 2024*, Data Sharing Platform: https://data.gov.rw/collections/360cab66-ac0e-4aa0-9c5e-43c052d0bf0a. The inspected archive contains 12 CSVs: Crop_Production, Household_Screening, Agricultural_Practices and Fertilizer_and_Pesticide_Use for Seasons A, B and C. Crop_Production has 39,330 Season A rows, 35,584 Season B rows and 1,949 Season C rows (76,863 total), with 96, 98 and 97 columns respectively. The inspection reports 83 crop names, 21 categories, five provinces and 30 districts. Season is assigned from the filename. Data dictionary workbook: SAS2024_Data_Dictionary.xlsx (774 metadata rows). Dataset page: https://data.gov.rw/datasets/f1fe0aa2-fbb5-4945-a4d7-796cd3703d00.

## Planned Tables
SEASON, GEOGRAPHIC_AREA, STRATUM, FARM_TYPE, CROP_CATEGORY, CROP, FARM_UNIT, PLOT, PRODUCTION_RECORD, PLOT_CROP, USE_TYPE, UTILIZATION, LOSS_TYPE, LOSS_RECORD, IMPORT_BATCH and IMPORT_REJECT. FARM_UNIT is unique by season, sampling segment and farmer ID. PRODUCTION_RECORD is at farmer-crop grain; PLOT_CROP is at plot-crop grain. UTILIZATION and LOSS_RECORD link to PRODUCTION_RECORD to prevent repeated values being counted once per plot. Causes s2q41–s2q44 are pre-harvest; s2q45–s2q50 are post-harvest. The s2q39 measure remains separate from the cause breakdown.

## Planned PL/SQL Features
IMPORT_PKG validates staged records and logs rejects; LOSS_PKG calculates explicitly defined descriptive indicators; REPORT_PKG provides crop, district and seasonal summaries. Explicit cursors support batch processing, triggers audit changes, and exceptions handle invalid references and duplicate keys.

## Innovation
A Python Streamlit dashboard connected to the actual Oracle database using python-oracledb. It will provide crop, season and district filters, production and utilization indicators, and separate pre-/post-harvest loss charts. Business rules remain in PL/SQL; the dashboard will query live Oracle data, not static mock-ups.

## Limitations
This is survey sample data, not a census. Season C has fewer observations and limited strata coverage. Geography is limited to province and district. The two loss measures do not always reconcile. Survey weights must not be applied to farmer-crop loss totals without confirming NISR's estimation methodology. Outputs will be labelled sample results unless official estimation methods are validated.

## References
Austin, K. G., Beach, R. H., Lapidus, D., Salem, M. E., Taylor, N. J., Knudsen, M., & Ujeneza, N. (2020). Impacts of climate change on the potential productivity of eleven staple crops in Rwanda. *Sustainability, 12*(10), 4116. https://doi.org/10.3390/su12104116

Ayabagabo, P. (2018). *Empirical analysis of seasonal rainfall variability and its associated effects on major food crop yields in Rwanda* [Master's dissertation, University of Nairobi]. https://cgspace.cgiar.org/items/266918e1-ba3a-42b4-b12b-01f2bd1ff0aa

Food and Agriculture Organization of the United Nations. (2025). *Crop production, yield and harvested area* [Dataset]. FAOSTAT. https://data.fao.org/catalog/iso/d24a448b-3b62-4c09-8c1d-4a39bb599876

Hakiruwizera, E., & Niragire, T. (2026). Seasonal cereal yield dynamics and climate variability in Rwanda: Evidence from official agricultural statistics, 2013–2025. *Agricultural Science and Engineering*. https://agriscieng.com/index.php/ASE/article/view/5. **Verify bibliographic details before submission.**

Ministry of Agriculture and Animal Resources. (2025). *Annual report 2023–2024*. https://www.minagri.gov.rw/fileadmin/user_upload/Minagri/Publications/Annual_Reports/MINAGRI_Annual_Report_for_2023-24_FY__FINAL.pdf

National Institute of Statistics of Rwanda. (2024). *Rwanda Seasonal Agricultural Survey 2024* [Dataset]. https://data.gov.rw/collections/360cab66-ac0e-4aa0-9c5e-43c052d0bf0a

Oracle. (2021). *Oracle Database 21c: Coding PL/SQL subprograms and packages*. https://docs.oracle.com/en/database/oracle/oracle-database/21/adfns/coding-subprograms-and-packages.html