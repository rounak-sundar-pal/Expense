namespace tripin.common;

using {Currency} from '@sap/cds/common';


type Gender      : String(1) enum {
    Male         = 'M';
    Female       = 'F';
    NoDisclosure = 'N';
};

type AMOUNT      : Decimal(15, 2) @(
    Semantics.amount.CurrencyCode: 'CURRENCY_CODE',
    sap.unit                     : 'CURRENCY_CODE'
);

aspect Amount {
    CURRENCY_CODE : Currency;
    AMOUNT        : AMOUNT;
}

type PhoneNumber : String(15) @assert.format: '^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$';
type Email       : String(255) @assert.format: '^(\s*|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$';
