--  Script:      010_SQL_Server_WT14_PRG018_Validation_RO.sql
--  Author:      aadan
--  Date:        02/03/2021
--  Purpose:     SQL Server validate. 

USE WebContent

DECLARE 
@COUNT0 INT

SELECT @COUNT0 = COUNT(p_program_code)
  FROM dbo.t_product
 WHERE p_program_code = 'WT14';

-- Count should be 1 after Deployment


if @COUNT0 > 0 
   print 'Validate successful ! Program code WT14 Found'
ELSE
   print 'Error WT14 not found.' 

SELECT @COUNT0 = COUNT(program_plastic_code)
  FROM dbo.t_program_plastic
  WHERE product_id = (SELECT  p_product_id FROM  t_product WHERE  p_program_code = 'WT14')   


if @COUNT0 = 1 
   print 'WT14 ROLLOUT successful! Program code WT14 has 1 records in t_program_plastic'
ELSE
   print 'WT14 ROLLOUT Failed: LESS than 1 records found in t_program_plastic.' 

SELECT @COUNT0 = COUNT(po_product_offer_id) 
from  dbo.t_product_offer 
        WHERE  po_product_id =(SELECT  p_product_id FROM  t_product WHERE  p_program_code = 'WT14') 
 
if @COUNT0 > 0 
   print 'ROLLOUT successful ! Program code WT14 ADDED to t_product_offer'
ELSE
   print 'WT14 ROLLOUT Failed:  records not found in t_product_offer.' 
