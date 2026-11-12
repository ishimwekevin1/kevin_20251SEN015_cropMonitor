# Database Design — Rwanda Crop Production and Post-Harvest Loss Monitoring System

Student: ISHIMWE Kevin (20251SEN015) | Course: INSY 8311

## Dataset evidence
The supplied inspection report states that the archive contains 12 CSVs (four survey tables for Seasons A, B and C). Crop_Production contains 39,330 Season A rows, 35,584 Season B rows and 1,949 Season C rows: 76,863 total. Column counts are 96, 98 and 97 respectively. The reported data dictionary has 774 metadata rows. Production data has 83 crop names, 21 crop categories, five provinces and 30 districts. Season is assigned from the filename because it is not a CSV column.

## Critical data grains
1. FARM_UNIT is identified within a season by (season, Segment_ID, farmer ID); farmer IDs are not globally unique.
2. PLOT belongs to FARM_UNIT and is identified by farm unit + plot number.
3. PLOT_CROP stores plot harvest s2q21 and plot area context.
4. PRODUCTION_RECORD is one farmer-unit/crop/season record and stores total crop harvest s2q22 and utilization-reported loss s2q39.
5. UTILIZATION and LOSS_RECORD link to PRODUCTION_RECORD, not to each plot. This prevents repeated farmer-crop totals being double-counted.
6. s2q39 and s2q41–s2q50 are distinct source measures. Causes s2q41–s2q44 are pre-harvest; s2q45–s2q50 are post-harvest.

## Tables
| Table | Grain / purpose |
|---|---|
| SEASON | One row per season code and agricultural year |
| GEOGRAPHIC_AREA | Province + district lookup |
| STRATUM | Survey stratum lookup |
| FARM_TYPE | Farmer type lookup |
| CROP_CATEGORY / CROP | Crop classification and crop lookup |
| FARM_UNIT | Season + segment + farmer ID; optional demographic attributes |
| PLOT | Farm unit + plot number; area and plot weight |
| PRODUCTION_RECORD | Farm unit + crop; s2q22 and s2q39 |
| PLOT_CROP | Plot + crop; s2q21 |
| USE_TYPE / UTILIZATION | One production record + utilization code + quantity |
| LOSS_TYPE / LOSS_RECORD | One production record + loss cause + quantity; loss stage PRE/POST |
| IMPORT_BATCH / IMPORT_REJECT | Source-file batch tracking and rejected raw rows |

## Quality controls and limitations
Preserve source values in staging. Do not map 9999 to NULL until the questionnaire confirms its meaning. Keep negative s2q47 values for review rather than silently deleting them. The inspection reports 4,981 Season A and 905 Season B records with no harvest data; retain them in staging and exclude them from harvest metrics only with a documented rule. Extreme values (including 258,000,000 kg in s2q22) require source review. Do not apply plot_weight to farmer-crop utilization/loss by joining every plot. National estimates require the official NISR weighting method.

Geography is limited to province and district. Season C is much smaller and reportedly covers only marshland and hillside strata. The questionnaire says reported harvest includes estimated post-harvest losses. The two loss measures do not always reconcile.

## PL/SQL and innovation
IMPORT_PKG validates staged rows and logs rejects; LOSS_PKG calculates explicitly defined descriptive indicators; REPORT_PKG provides crop/district/season summaries. Use explicit cursors for batch processing, triggers for audit, and exceptions for invalid references and duplicate keys. Innovation: Streamlit + python-oracledb connected to the real Oracle database, not static mock data.

Implementation note: accompanying SQL is a starter design and has not been tested against an Oracle instance.