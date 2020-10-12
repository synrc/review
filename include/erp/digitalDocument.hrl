-ifndef(DIGIDOC_HRL).
-define(DIGIDOC_HRL, true).

-record('Signature', {hash, body}).

-record(digitalDocument, { id = [], % контейнер цифрового докумнета
                           body = [] :: #citizenInquire{},
                           watermark = [],
                           qrcode = [], % штрих-код
                           timestamp = [],
                           signature = [] :: list(#'Signature'{}) }).

-endif.
