--  Script:      010_WebContentAtSQL_Server_Product_WT14_PRG018_Deploy.sql
--  Author:      aadan
--  Date:        02/03/2021
--  Purpose:     SQL Server deployment.


USE WebContent 

DECLARE 
@COUNT0 INT

SELECT @COUNT0 = COUNT(p_program_code)
  FROM dbo.t_product
 WHERE p_program_code = 'WT14';
 
IF @COUNT0 = 0
BEGIN 
	 
	BEGIN TRANSACTION ;

	INSERT INTO t_product (
		p_product_id,
		p_program_code,
		p_language_id,
		p_product_type_id,
		p_premium_card_fee,
		p_hidden,
		p_valid,
		p_secured_type,
		p_auth_user,
		p_program_threshold,
                p_has_premium_plastic_recurring_fee,
	        p_bt_ad_image_visible,
	        p_bt_interest_chk_visible )
		SELECT MAX(p_product_id) + 1,
			   'WT14',  -- program_code
			   1,       -- 1 or 2 language_id
			   2,       -- 1 or 2 product_type_id
			   0.00,    -- premium_card_fee
			   0,       -- hidden
			   0,       -- valid must be 0 for LD programs
			   'U',     -- U or S secured_type
			   1,       -- 0 or 1 authorized user
			   500,    -- amount of income required
			   0,      -- 1 if it's a premium plastic with recurring fee else 0
                           0,
                           0      
		  FROM t_product

	COMMIT TRANSACTION ;
END
ELSE
	print 'WT14 already exists in t_product.' 
