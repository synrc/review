-ifndef(CRED_REG).
-define(CRED_REG, true).

-record(credentials, {auth_type,cn,branch,otp,bool,code,person_signature}).

-endif.
