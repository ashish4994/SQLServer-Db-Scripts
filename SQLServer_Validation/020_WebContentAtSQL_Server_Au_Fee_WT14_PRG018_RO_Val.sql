--  Script:      020_WebContentAtSQL_Server_Au_Fee_WT14_PRG018_RO_Val.sql
--  Author:      aadan
--  Date:        02/03/2021
--  Purpose:     SQL Server validate. 

USE WebContent

DECLARE 
@COUNT0 INT

SELECT @COUNT0 = COUNT(p_program_code)
  FROM dbo.t_au_fee_term_info
 WHERE p_program_code = 'WT14';

-- Count should be 1 after Deployment

IF @COUNT0 > 0 
   print 'Validate successful ! Aut. Fee for program code WT14 Found'
ELSE
   print 'Error Aut. Fee not found.' 
