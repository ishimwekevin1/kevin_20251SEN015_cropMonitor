-- Grain-safe analytical query examples.
SELECT s.season_code,c.crop_name,COUNT(*) farmer_crop_records,SUM(pr.total_crop_harvest_kg) sample_crop_harvest_kg
FROM production_record pr JOIN farm_unit fu ON fu.farm_unit_id=pr.farm_unit_id
JOIN season s ON s.season_id=fu.season_id JOIN crop c ON c.crop_id=pr.crop_id
GROUP BY s.season_code,c.crop_name;

SELECT s.season_code,ga.province,ga.district,SUM(pc.plot_harvest_kg) sample_plot_harvest_kg
FROM plot_crop pc JOIN plot p ON p.plot_id=pc.plot_id JOIN farm_unit fu ON fu.farm_unit_id=p.farm_unit_id
JOIN season s ON s.season_id=fu.season_id JOIN geographic_area ga ON ga.area_id=fu.area_id
GROUP BY s.season_code,ga.province,ga.district;

SELECT s.season_code,c.crop_name,ga.district,SUM(pc.plot_harvest_kg)/NULLIF(SUM(p.plot_area_m2)/10000,0) sample_yield_kg_per_ha
FROM plot_crop pc JOIN plot p ON p.plot_id=pc.plot_id JOIN farm_unit fu ON fu.farm_unit_id=p.farm_unit_id
JOIN season s ON s.season_id=fu.season_id JOIN geographic_area ga ON ga.area_id=fu.area_id
JOIN crop c ON c.crop_id=pc.crop_id GROUP BY s.season_code,c.crop_name,ga.district;

SELECT s.season_code,ut.use_label,SUM(u.quantity_kg) sample_quantity_kg
FROM utilization u JOIN use_type ut ON ut.use_code=u.use_code JOIN production_record pr ON pr.production_id=u.production_id
JOIN farm_unit fu ON fu.farm_unit_id=pr.farm_unit_id JOIN season s ON s.season_id=fu.season_id
GROUP BY s.season_code,ut.use_label;

SELECT s.season_code,lt.loss_label,SUM(lr.quantity_kg) sample_loss_kg
FROM loss_record lr JOIN loss_type lt ON lt.loss_code=lr.loss_code JOIN production_record pr ON pr.production_id=lr.production_id
JOIN farm_unit fu ON fu.farm_unit_id=pr.farm_unit_id JOIN season s ON s.season_id=fu.season_id
WHERE lt.loss_stage='PRE' GROUP BY s.season_code,lt.loss_label;

SELECT s.season_code,lt.loss_label,SUM(lr.quantity_kg) sample_loss_kg
FROM loss_record lr JOIN loss_type lt ON lt.loss_code=lr.loss_code JOIN production_record pr ON pr.production_id=lr.production_id
JOIN farm_unit fu ON fu.farm_unit_id=pr.farm_unit_id JOIN season s ON s.season_id=fu.season_id
WHERE lt.loss_stage='POST' GROUP BY s.season_code,lt.loss_label;

WITH cause_totals AS (SELECT production_id,SUM(quantity_kg) cause_loss_kg FROM loss_record GROUP BY production_id)
SELECT s.season_code,SUM(pr.utilization_reported_loss_kg) s2q39_total_kg,SUM(ct.cause_loss_kg) cause_breakdown_total_kg
FROM production_record pr JOIN farm_unit fu ON fu.farm_unit_id=pr.farm_unit_id JOIN season s ON s.season_id=fu.season_id
LEFT JOIN cause_totals ct ON ct.production_id=pr.production_id GROUP BY s.season_code;

-- Weighting warning: plot_weight is plot-level. Do not join plot weights to
-- farmer-crop utilization/loss totals. Verify NISR's estimation method first.