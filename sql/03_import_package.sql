-- Starter package: batch reject logging. CSV parsing/loading is performed by
-- a CSV-aware client or SQL*Loader; this does not assume arbitrary local-file access.
CREATE OR REPLACE PACKAGE import_pkg AS
  PROCEDURE log_reject(p_batch_id IN NUMBER, p_source_row_number IN NUMBER, p_reason IN VARCHAR2, p_raw_payload IN CLOB);
  PROCEDURE mark_batch_complete(p_batch_id IN NUMBER, p_rows_read IN NUMBER, p_rows_loaded IN NUMBER, p_rows_rejected IN NUMBER);
END import_pkg;
/
CREATE OR REPLACE PACKAGE BODY import_pkg AS
  PROCEDURE log_reject(p_batch_id IN NUMBER, p_source_row_number IN NUMBER, p_reason IN VARCHAR2, p_raw_payload IN CLOB) IS
  BEGIN
    INSERT INTO import_reject(batch_id,source_row_number,reject_reason,raw_payload) VALUES(p_batch_id,p_source_row_number,SUBSTR(p_reason,1,1000),p_raw_payload);
    UPDATE stg_crop_production SET processing_status='REJECTED', processing_message=SUBSTR(p_reason,1,1000) WHERE batch_id=p_batch_id AND source_row_number=p_source_row_number;
  END;
  PROCEDURE mark_batch_complete(p_batch_id IN NUMBER, p_rows_read IN NUMBER, p_rows_loaded IN NUMBER, p_rows_rejected IN NUMBER) IS
  BEGIN
    UPDATE import_batch SET completed_at=SYSTIMESTAMP, rows_read=p_rows_read, rows_loaded=p_rows_loaded, rows_rejected=p_rows_rejected, batch_status='COMPLETED' WHERE batch_id=p_batch_id;
    IF SQL%ROWCOUNT=0 THEN RAISE_APPLICATION_ERROR(-20001,'Import batch not found: '||p_batch_id); END IF;
  END;
END import_pkg;
/