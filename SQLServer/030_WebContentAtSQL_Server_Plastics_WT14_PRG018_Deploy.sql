--  Script:      030_WebContentAtSQL_Server_Plastics_WT14_PRG018_Deploy.sql
--  Author:      aadan
--  Date:        02/03/2021
--  Purpose:     SQL Server deployment.

USE WebContent

DECLARE 
@COUNT0 INT

SELECT @COUNT0 = COUNT(product_id)
  FROM dbo.t_program_plastic
 WHERE product_id = (SELECT  p_product_id FROM  t_product WHERE  p_program_code = 'WT14');
 
IF @COUNT0 = 0
BEGIN

	SET IDENTITY_INSERT t_program_plastic ON;

	INSERT INTO t_program_plastic
		(program_plastic_id,
		 product_id,
		 plastic_design_id,
		 program_plastic_code,
		 is_premium)
		SELECT MAX(program_plastic_id) + 1,
			   (SELECT top 1 p_product_id
				  FROM t_product
				 WHERE p_program_code = 'WT14'),
			   (SELECT top 1 plastic_design_id
				  FROM t_lu_plastic_design
				 WHERE plastic_code = 'DD'),
			   1,
			   0
		  FROM t_program_plastic
		  

	SET IDENTITY_INSERT t_program_plastic OFF;
	END
ELSE
	print 'WT14 program plastics already exists in t_program_plastic.' 
