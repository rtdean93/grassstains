CREATE OR REPLACE PROCEDURE SP_DEL_CONSUMER_ACCESS_TOKEN
(
P_USER_ID                      IN        NUMBER,
P_TOKEN                        IN        VARCHAR2,
P_USER_IS_ADMIN                IN        NUMBER, -- 1:YES; 0:NO
P_RESULT                       OUT       NUMBER
)
AS

 -- PROCEDURE TO Delete a consumer access token.
 
BEGIN

  P_RESULT := 0;
  
  IF P_USER_IS_ADMIN = 1 THEN
    DELETE FROM OAUTH_SERVER_TOKEN
    WHERE OST_TOKEN 	 = P_TOKEN
    AND OST_TOKEN_TYPE = 'ACCESS';
  ELSE
    DELETE FROM OAUTH_SERVER_TOKEN
    WHERE OST_TOKEN 	 = P_TOKEN
    AND OST_TOKEN_TYPE = 'ACCESS'
    AND OST_USA_ID_REF = P_USER_ID;
  END IF;
  
EXCEPTION
WHEN OTHERS THEN
-- CALL THE FUNCTION TO LOG ERRORS
ROLLBACK;
P_RESULT := 1; -- ERROR
END;
/
