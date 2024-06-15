from fastapi import HTTPException, Header
import jwt


def auth_middleware(x_auth_token=Header()):
    try:
        #get the user token in headers,
        if not x_auth_token:
            raise HTTPException(400,'No auth Token! access denied')
        # decode the token
        verifiede_token = jwt.decode(x_auth_token,'password_key',['HS256']);
        if not verifiede_token:
            raise HTTPException(400,'Token Verification failed! access denied')
        # get the id from the token
        uid = verifiede_token.get('id')
        return {'uid':uid,'token':x_auth_token}
        #postgress db get the user info
    except jwt.PyJWKError :
        raise HTTPException(400,'Invalid Token! authorization failed');