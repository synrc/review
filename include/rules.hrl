-ifndef(BUSINESS_RULES).
-define(BUSINESS_RULES, true).

-record(docnum, {id,desc,generator=[], validator=[], pattern=[], period="1y", prefix=[], postfix=[]}).

-endif.
