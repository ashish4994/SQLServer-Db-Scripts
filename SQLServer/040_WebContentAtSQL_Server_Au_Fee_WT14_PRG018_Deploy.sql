--  Script:      040_WebContentAtSQL_Server_Au_Fee_WT14_PRG018_Deploy.sql
--  Author:      aadan
--  Date:        02/03/2021
--  Purpose:     SQL Server deployment.


USE WebContent  

DECLARE 
@COUNT0 INT

SELECT @COUNT0 = COUNT(p_program_code)
  FROM dbo.t_au_fee_term_info
 WHERE p_program_code = 'WT14';
 
IF @COUNT0 = 0
	BEGIN
 
	BEGIN TRANSACTION ;

	INSERT INTO t_au_fee_term_info (p_program_code
		  ,p_au_fee
		  ,p_term)

	  values('WT14',0,1);

	COMMIT TRANSACTION ;
	END
ELSE
	print 'WT14 already exists in t_au_fee_term_info.' 

