/*
===============================
Quality Checks
===============================
Script purpose:
  This script perfoms various quality check for data consistency,accuracy and standardization
  accross silver schemas. it include checks;
    -Null or duplicates primary keys
    -unwantend spaces in string fields
    -Data standardization and consistency
    -invalid date ranges and orders
    -Data consistency between related fields
Usage Notes:
  -Run this checks after data loading silver layer
  -Investigate and resolve any descrapancies found during the check
*/

-- ==================================
-- Checking for silver.crm_cust_info
-- ==================================
 -- Check for null or duplicates on the primary key
--Expectations: no result
SELECT
*
FROM silver.crm_cust_info


SELECT
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

SELECT
*
FROM silver.crm_cust_info
WHERE cst_id = 29466

SELECT
*
FROM (
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) flag_last
FROM silver.crm_cust_info
)t WHERE flag_last != 1

-- Data Transformation for clean up
SELECT
*
FROM (
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) flag_last
FROM silver.crm_cust_info
)t WHERE flag_last = 1 AND cst_id = 29483


-- ===========================================
-- Checking for silver.crm_prd_info
-- ===========================================

-- Checking for null and duplicates in my data
-- Expectation: No Result

SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted spaces
--Expectation: No Results
SELECT
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for nulls or negative numbers
SELECT
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL


-- Data Standardization and consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check for invalid Date orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

-- ======================================
-- Checking for silver.crm_sales_details
-- ======================================

  -- Checking for unwanted spaces
  --WHERE sls_ord_num != TRIM(sls_ord_num)

  -- checkng the integrity of key and id
  WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info)
 --WHERE  sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info)

 -- check for invalid dates
 SELECT
 NULLIF(sls_order_dt, 0) sls_order_dt
 FROM silver.crm_sales_details
 WHERE sls_order_dt <= 0
 OR LEN(sls_order_dt) != 8

 -- Checking for invalid date orders
 SELECT
 *
 FROM bronze.crm_sales_details
 WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

 -- Check consistency between sales, quantity and price
 
 SELECT DISTINCT
 sls_sales  AS old_Sales,
  CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_quantity)
            THEN sls_quantity * ABS(sls_quantity)
       ELSE sls_sales
  END sls_sales,
 sls_quantity,
 sls_price AS old_price,
 CASE WHEN sls_price IS NULL OR sls_price <= 0
    THEN sls_sales / NULLIF(sls_quantity, 0)
    ELSE sls_price
 END sls_price
 FROM silver.crm_sales_details
 WHERE sls_sales != sls_price * sls_quantity
 OR sls_sales IS NULL OR sls_price IS NULL OR sls_quantity IS NULL
 OR sls_sales <= 0 OR sls_price <= 0 OR sls_quantity <= 0  
 ORDER BY sls_sales, sls_quantity, sls_price


 -- RULES: If sales is negative,zero or null derive it using quantity and price
 -- if price is zero or null calculate it using sales and quantity
 -- If price is negative convert it to posistive value
-- ===========================================
-- Check for silver.erp_cust_az12
-- ===========================================
SELECT 
    cid,
    CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
        ELSE cid
    END AS cid, -- checking if there is differrnt between id and custkey removing what is not there
  
    CASE WHEN bdate > GETDATE() THEN NULL
        ELSE bdate
    END bdate,

    gen,
    CASE 
        WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) in ('M', 'MALE') THEN 'Male'
        ELSE 'Unknown'
    END
  FROM silver.erp_cust_az12
  --WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
       -- ELSE cid
    --END NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)
 

 -- SELECT * FROM silver.crm_cust_info

 -- Identifying out-of-ranfe dates
 SELECT DISTINCT
 bdate
 FROM silver.erp_cust_az12
 WHERE bdate < '1924-01-01' OR bdate > GETDATE()

 -- Data standardization and consistency
 SELECT DISTINCT
    CASE 
        WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
        ELSE 'Unknown'
 END AS gen
 FROM silver.erp_cust_az12
  
-- ===================================
-- Checking for  silver.erp_loc_a101
-- ===================================
    
    SELECT
	REPLACE(cid, '-', '') AS cid, -- handle invalid values
	cntry
FROM bronze.erp_loc_a101
WHERE REPLACE(cid, '-', '')  NOT IN (SELECT cst_key FROM Bronze.crm_cust_info)

-- Data standardization and consistency
SELECT DISTINCT cntry
FROM silver.erp_loc_a101

-- ======================================================
    -- Checking for silver.erp_px_cat_g1v2
-- ======================================================
-- check for unwanted spaces
SELECT 
	*
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)

-- Data standardization and consistency
SELECT DISTINCT
	--cat,
	--subcat,
	maintenance
FROM silver.erp_px_cat_g1v2

    -- Cheking if data is loaded successfully
SELECT * FROM Silver.erp_px_cat_g1v2


