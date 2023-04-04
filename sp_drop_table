CREATE OR REPLACE PROCEDURE rondow.sp_drop_table (TAB_OWNER IN VARCHAR2,TAB_NAME IN VARCHAR2)
AUTHID CURRENT_USER AS
/********************************************************************************
** Author:       rondow
** Created:      20230126
** Purpose:      Stored Proc to Drop Specified Table 
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
BEGIN 
	 FOR i IN (SELECT COUNT(*) AS TABCNT, MAX(OWNER)||'.'||MAX(TABLE_NAME) AS OWN_TABNAME
				FROM ALL_TABLES
			   WHERE OWNER = TAB_OWNER AND TABLE_NAME = TAB_NAME) LOOP
		CASE WHEN i.TABCNT > 0 
		THEN DBMS_OUTPUT.put_line('DROPPING TABLE '|| i.OWN_TABNAME);  
			 EXECUTE IMMEDIATE 'DROP TABLE ' || i.OWN_TABNAME;   
		ELSE DBMS_OUTPUT.put_line('NO TABLE TO DROP'); 
	  END CASE;
	 END LOOP; 
	 EXCEPTION WHEN OTHERS THEN RAISE;
END;
/
---------------------------------------------
EXECUTE rondow.sp_drop_table(TAB_OWNER => 'rondow', TAB_NAME => 'rondow_test_drop');
---------------------------------------------

SQL_STMT VARCHAR2(3500) := 'SELECT 1 FROM DUAL';


BEGIN 
     FOR i IN (SELECT ROWNUM AS tabcnt,
                  OWNER||'.'||TABLE_NAME AS OWN_TAB_NAME FROM ALL_TABLES
                WHERE OWNER = 'rondow' AND TABLE_NAME = 'rondow_test_drop') LOOP
        CASE 
		  WHEN i.tabcnt > 0  
            THEN DBMS_OUTPUT.put_line('DROPPING TABLE '|| i.OWN_TAB_NAME || 'AND CREATING TABLE');  
                 EXECUTE IMMEDIATE 'DROP TABLE ' || i.OWN_TAB_NAME; 
		         SQL_STMT;
          ELSE DBMS_OUTPUT.put_line('NO TABLE TO DROP, Creating Table'); 
		       EXECUTE IMMEDIATE SQL_STMT;
		END CASE;
     END LOOP; 
END;
