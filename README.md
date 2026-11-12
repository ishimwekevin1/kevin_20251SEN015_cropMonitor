# Rwanda Crop Production and Post-Harvest Loss Monitoring System

**Student:** ISHIMWE Kevin — **ID:** 20251SEN015  
**Course:** INSY 8311 — Database Development with PL/SQL

## Problem and objectives
Build a normalized Oracle database and interactive dashboard for exploring Rwanda seasonal crop production, utilization and reported pre-/post-harvest losses. The design respects plot and farmer-crop grains to prevent double-counting.

## Dataset
NISR Rwanda Seasonal Agricultural Survey 2024. The inspected archive contains 12 CSVs (four survey tables × three seasons). Crop_Production row counts reported from inspection: Season A 39,330; Season B 35,584; Season C 1,949; **total 76,863**. It includes 83 crop names, 21 categories, five provinces and 30 districts. Season is assigned from each source filename. Data dictionary: SAS2024_Data_Dictionary.xlsx (774 metadata rows).

Collection: https://data.gov.rw/collections/360cab66-ac0e-4aa0-9c5e-43c052d0bf0a

## Repository
- docs/proposal — Phase 0 proposal
- docs/research — research log
- docs/database — database design and ERD
- docs/presentation — 12-slide outline
- sql — Oracle DDL, staging, PL/SQL starter and analytical queries
- SUBMISSION_CHECKLIST.md — final actions

## Planned PL/SQL
Import validation and reject logging, loss indicator functions, reporting package, explicit cursors, audit triggers and exception handling.

## Innovation
Streamlit dashboard connected to the real Oracle database through python-oracledb. Live Oracle data is required; static mock-ups do not satisfy the innovation requirement.

## Limitations
Survey sample, not census; Season C is smaller; geographic detail is province/district; source loss measures do not always reconcile. National estimates require verified survey-weight methodology. SQL scripts are starter files and have not yet been tested in Oracle.

Research references and source notes: docs/research/research_log.md.