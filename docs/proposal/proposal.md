# Rwanda Crop Production and Post-Harvest Loss Monitoring System

**Student:** Kevin ISHIMWE  
**Student ID:** 20251SEN015  
**Course:** INSY 8311 – Database Development with PL/SQL  
**Instructor:** Eric Maniraguha

## Problem Statement
Agricultural planning depends on timely and reliable information about crop production, harvested quantities, crop utilization and post-harvest losses. Rwanda's Seasonal Agricultural Survey publishes valuable seasonal statistics, but users who need to compare crops, seasons, districts and loss patterns may have to work across separate datasets and reports. Without a structured database and accessible summaries, it is harder to identify where production is changing and which post-harvest loss causes deserve attention. This project will organize public, non-identifying agricultural survey data into a normalized Oracle database and provide searchable reports.

## Proposed Solution
Develop an Oracle database application that stores crop, season, geographic, production and post-harvest loss information. Users will be able to filter records by season, district, crop and farm category; review harvested quantities and use of produce; and compare reported loss categories. The application will validate imported records and use PL/SQL business rules to calculate derived indicators consistently. It is an analytical monitoring prototype, not a replacement for NISR's official statistical production process.

## Data Source
Primary source: National Institute of Statistics of Rwanda (NISR), Rwanda Seasonal Agricultural Survey 2024, Season C: Crop Production (July–September 2024), Data Sharing Platform: https://data.gov.rw/datasets/f1fe0aa2-fbb5-4945-a4d7-796cd3703d00. The published dataset page describes plot-level crop production records, 97 columns, nationwide coverage and crop utilization and post-harvest loss variables. The platform's usage guidance permits reuse and adaptation with source attribution. Before loading, I will download the CSV, inspect its row count and data dictionary, remove any direct identifiers if present, and retain a documented subset of fields relevant to the project. The assignment requires a few hundred records or more; this must be confirmed from the downloaded file before final data loading. A supplementary long-term source is FAOSTAT Crop Production, Yield and Harvested Area (1961–2024): https://data.fao.org/catalog/iso/d24a448b-3b62-4c09-8c1d-4a39bb599876.

## Planned Tables
1. **SEASON** (`season_id`, `season_name`, `start_date`, `end_date`, `agricultural_year`)
2. **GEOGRAPHIC_AREA** (`area_id`, `province`, `district`, `sector`)
3. **CROP** (`crop_id`, `crop_name`, `crop_category`)
4. **FARM_TYPE** (`farm_type_id`, `farm_type_name`)
5. **PRODUCTION_RECORD** (`record_id`, `season_id`, `area_id`, `crop_id`, `farm_type_id`, `harvest_quantity`, `remaining_quantity`, `harvested_area_ha`, `yield_value`, `seed_type`, `seed_source`)
6. **UTILIZATION** (`utilization_id`, `record_id`, `consumed_quantity`, `sold_quantity`, `stored_quantity`, `other_use_quantity`)
7. **LOSS_RECORD** (`loss_id`, `record_id`, `loss_stage`, `loss_cause`, `loss_quantity`)
8. **IMPORT_AUDIT** (`audit_id`, `source_file`, `imported_at`, `rows_loaded`, `rows_rejected`, `loaded_by`)

The design separates crop, season, geography and farm-type reference data from plot-level facts to reduce duplication and support 3NF. Exact columns and keys will be finalized after inspecting the dataset's data dictionary.

## Planned PL/SQL Features
- `load_production_record`: validate and insert staged records; reject invalid quantities and missing reference values.
- `calculate_loss_rate`: return the percentage of harvested quantity lost, with division-by-zero handling.
- `get_crop_summary`: return aggregate production and yield by crop, district and season.
- `report_pkg`: package the import, summary and validation routines.
- Explicit cursor: iterate through staged records during controlled import and report rejected rows.
- Triggers: prevent negative quantities and write changes to an audit table.
- Exceptions: handle missing crop/season references, invalid quantities and duplicate source records with clear error messages.

## Innovation
**Option:** User interface and analytics dashboard.  
**Tool:** Python Streamlit connected to the real Oracle database through `python-oracledb`. The interface will provide filters, KPI cards and charts for production, utilization and loss causes. Users will be able to invoke approved PL/SQL package procedures for validation and summaries. The dashboard will query the actual Oracle database; it will not use static mock data. Business rules remain in PL/SQL.

## References
Austin, K. G., Beach, R. H., Lapidus, D., Salem, M. E., Taylor, N. J., Knudsen, M., & Ujeneza, N. (2020). Impacts of climate change on the potential productivity of eleven staple crops in Rwanda. *Sustainability, 12*(10), 4116. https://doi.org/10.3390/su12104116

Ayabagabo, P. (2018). *Empirical analysis of seasonal rainfall variability and its associated effects on major food crop yields in Rwanda* [Master's dissertation, University of Nairobi]. CGIAR CGSpace. https://cgspace.cgiar.org/items/266918e1-ba3a-42b4-b12b-01f2bd1ff0aa

Food and Agriculture Organization of the United Nations. (2025). *Crop production, yield and harvested area (Global, National – Annual)* [Dataset]. FAOSTAT. https://data.fao.org/catalog/iso/d24a448b-3b62-4c09-8c1d-4a39bb599876

Hakiruwizera, E., & Niragire, T. (2026). Seasonal cereal yield dynamics and climate variability in Rwanda: Evidence from official agricultural statistics, 2013–2025. *Agricultural Science and Engineering*. https://agriscieng.com/index.php/ASE/article/view/5

National Institute of Statistics of Rwanda. (2026). *Season C: Crop Production* [Dataset]. Data Sharing Platform. https://data.gov.rw/datasets/f1fe0aa2-fbb5-4945-a4d7-796cd3703d00

Ministry of Agriculture and Animal Resources. (2025). *Annual report 2023–2024*. https://www.minagri.gov.rw/fileadmin/user_upload/Minagri/Publications/Annual_Reports/MINAGRI_Annual_Report_for_2023-24_FY__FINAL.pdf

Oracle. (2021). *Oracle Database 21c: Coding PL/SQL subprograms and packages*. https://docs.oracle.com/en/database/oracle/oracle-database/21/adfns/coding-subprograms-and-packages.html
