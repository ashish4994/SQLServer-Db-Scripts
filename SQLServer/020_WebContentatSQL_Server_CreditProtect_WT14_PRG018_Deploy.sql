--  Script:      020_WebContentatSQL_Server_CreditProtect_WT14_PRG018_Deploy.sql
--  Author:      aadan
--  Date:        02/03/2021
--  Purpose:     SQL Server deployment.

--NOTE: this script needs to run for all Programs the use CreditProtection and/or RushProcess

USE WebContent

DECLARE  @po_product_id INT;
DECLARE  @po_offer_id INT;
DECLARE  @po_product_offer_id INT;
DECLARE  @COUNT0 INT;

 
 SET  @po_product_id = (SELECT  p_product_id FROM  t_product WHERE  p_program_code = 'WT14');
 SET  @po_offer_id = (SELECT o_offer_id FROM  t_offer WHERE  o_offer_name = 'CRDTPROTECT');
 SET  @po_product_offer_id = (SELECT MAX(po_product_offer_id) + 1 FROM t_product_offer);
 SELECT @COUNT0 = COUNT(po_product_id)
  FROM dbo.t_product_offer
 WHERE po_product_id = @po_product_id;

IF @po_product_id > 0 and @COUNT0 = 0
BEGIN
	BEGIN TRANSACTION ;
		INSERT INTO t_product_offer (
				   po_product_offer_id,
				   po_product_id,
				   po_offer_id,
				   po_sort)
			 VALUES (
					@po_product_offer_id,
					@po_product_id, 
					@po_offer_id, 
					0)
	COMMIT TRANSACTION ;
END
ELSE
	print 'WT14 already exists in t_product_offer.'
 

