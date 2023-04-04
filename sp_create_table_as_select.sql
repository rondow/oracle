CREATE OR REPLACE PROCEDURE rondow.sp_create_table_as_select
AUTHID CURRENT_USER AS
/********************************************************************************
** Author:       rondow
** Created:      20230126
** Purpose:      Create Table from a Select
**               
** Parameter(s): 
**
** Usage: 
**
*********************************************************************************
** Modification History:
** Date(yyyymmdd)           Modified By                  Comments
********************* ********************** ************************************
**   20230126               Oronde W.        Intial create
**                                            
********************************************************************************/

TABCNT NUMBER;
SQL_STMT CLOB := 'CREATE TABLE rondow.tmp_rondow_test_create AS 
                   SELECT ''TESTING'' AS COLUMN_1 FROM DUAL';
TAB_OWNER VARCHAR2(10) :='rondow';
TAB_NAME VARCHAR2(50) :='tmp_rondow_test_create';

BEGIN
 SELECT COUNT(*) INTO TABCNT FROM ALL_TABLES WHERE OWNER = TAB_OWNER AND TABLE_NAME = TAB_NAME;
  IF (TABCNT <= 0) THEN DBMS_OUTPUT.put_line('CREATING TABLE '||TAB_NAME);
    EXECUTE IMMEDIATE SQL_STMT;
   ELSIF (TABCNT >= 0) THEN DBMS_OUTPUT.put_line('ORA-00955:Please drop table '||TAB_OWNER||'.'||TAB_NAME); 
 END IF;
END;
/
------------------------------------------------------------------------------
EXECUTE rondow.sp_create_table_as_select();
------------------------------------------------------------------------------

TABCNT NUMBER;
SQL_STMT VARCHAR2(3500);

BEGIN
 SELECT COUNT(*) INTO TABCNT FROM ALL_TABLES WHERE OWNER = 'rondow' AND TABLE_NAME = 'tmp_rondow_test_create';
  IF (TABCNT <= 0) THEN SQL_STMT := 'CREATE TABLE rondow.tmp_rondow_test_create AS 
                                      SELECT ''TESTING'' AS COLUMN1 FROM DUAL';
   EXECUTE IMMEDIATE SQL_STMT;
 END IF;
EXCEPTION
  WHEN OTHERS THEN
      IF SQLCODE = -955 THEN DBMS_OUTPUT.put_line('PLEASE DROP TABLE');
       ELSIF SQLCODE != -955 THEN RAISE;
      END IF;
END;

------------------------------------------------------------------------------
TABCNT NUMBER;
SQL_STMT VARCHAR2(3500);

BEGIN
 SELECT COUNT(*) INTO TABCNT FROM ALL_TABLES WHERE OWNER = 'rondow' AND TABLE_NAME = 'tmp_rondow_test_create';
  IF (TABCNT <= 0) THEN DBMS_OUTPUT.put_line('CREATING TABLE');
     SQL_STMT := 'CREATE TABLE rondow.tmp_rondow_test_create AS 
                   SELECT ''TEST'' AS COLUMN1 FROM DUAL';
    EXECUTE IMMEDIATE SQL_STMT;
   ELSIF (TABCNT >= 0) THEN DBMS_OUTPUT.put_line('ORA-00955:Please drop table rondow.tmp_rondow_test_create'); 
 END IF;
END;
