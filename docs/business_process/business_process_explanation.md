# Phase I – Business Process Explanation

**Process:** Agricultural Survey Data Import, Validation, Storage and Analytical Reporting  
**System:** Rwanda Crop Production and Post-Harvest Loss Monitoring System  
**Student:** ISHIMWE Kevin — 20251SEN015  
**Course:** INSY 8311 — Database Development with PL/SQL

## Purpose and expected outcome
The process transforms public Rwanda Seasonal Agricultural Survey (SAS) CSV data into traceable, validated records and descriptive reports for agricultural analysis. It addresses the difficulty of comparing production, utilization and reported post-harvest-loss patterns across seasons, crops and districts while reducing invalid imports and aggregation errors. The expected outcome is a validated Oracle dataset and analytical summaries that support exploratory agricultural planning. This student prototype does not replace official NISR statistical estimation.

## Actors and responsibilities
- **Data administrator:** obtains the public survey files, records source metadata, prepares and submits import batches, and reviews rejected records.
- **Database/validation routines (Oracle PL/SQL):** check required fields, formats, reference values, duplicate keys and numeric/business constraints; record accepted and rejected rows and error reasons.
- **Oracle database:** stores accepted reference and fact records, import-batch metadata and rejection/audit evidence; supports retrieval and aggregation.
- **Analyst/dashboard user:** selects season, district, crop and farm category, retrieves summaries and reviews indicators/charts.
- **Agricultural planner/decision-maker:** interprets the descriptive outputs for planning and investigation, with awareness of survey and weighting limitations.
- **NISR dataset provider (external):** publishes the survey data and accompanying documentation; is not represented as an operator of this prototype.

## Process flow and decisions
The administrator obtains and documents a source CSV, then submits it for staging/import. The validation routines inspect the batch. If validation fails, the system logs rejected rows and reasons; the administrator reviews/corrects the source or mapping and re-submits, or ends the batch without loading invalid records. If records pass, the routines load them into Oracle with source/batch traceability and audit information. The analyst queries the stored data, applies supported filters, and views calculated descriptive indicators and summaries. The planner interprets the reports for decision support. Invalid or unsupported data is not silently accepted.

## Data-generating and data-touching activities
- **Create:** register import batch/source metadata; insert accepted staging/production and reference data as applicable; log rejected rows and validation errors; record audit events.
- **Update:** correct staging/mapping or reference values where permitted; update batch status and processing metadata; auditable updates to permitted records.
- **Retrieve:** validate against reference tables; query accepted records; filter and aggregate production, utilization and reported-loss data for dashboard outputs.
- **Archive/retain:** retain source and batch/rejection evidence for traceability according to project retention needs. No routine hard-delete is included in the proposed workflow; any deletion should be controlled and audited.

## Information flow and analytical cautions
Source CSV and metadata flow to staging and validation; validation results flow to batch status and rejection logs; accepted records flow to normalized Oracle tables; query results flow to the dashboard and reports. The model distinguishes plot-crop harvest from farmer-crop utilization and reported-loss facts to avoid multiplying farmer-crop totals when joining plot rows. Reported loss and loss-cause breakdowns are kept distinct. Survey sample totals are descriptive and must not be presented as national estimates without applying and confirming the official estimation methodology and weights.

## Why the process matters
A controlled import and reporting process improves consistency, traceability and usability of survey data. It supports exploratory comparisons by crop, district and season and makes data-quality issues visible to analysts and users. The dashboard is decision-support only; interpretation must consider the sample design, data definitions and limitations.
