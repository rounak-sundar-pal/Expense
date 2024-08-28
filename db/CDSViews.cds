namespace tripin.db;

using {tripin.db.transaction} from './datamodel.cds';

context CDSViews {
    define view ![MemberPayment] as
            select from transaction.member_payment {
                ID                  as ![PaymentGuid],
                paymentNo           as ![PaymentNumber],
                tripId.tripId       as ![TripNumber],
                tripId.year         as ![Year],
                tripId.month        as ![Month],
                memberId.memberName as ![PaidBy],
                paymentDate         as ![PaymentDate],
                AMOUNT              as ![AmountPaid],
                CURRENCY_CODE       as ![CurrencyCode]
            }
        union
            select from transaction.member_expense {
                ID                as ![PaymentGuid],
                expenseNo         as ![PaymentNumber],
                tripId.tripId     as ![TripNumber],
                tripId.year       as ![Year],
                tripId.month      as ![Month],
                paidBy.memberName as ![PaidBy],
                expenseDate       as ![PaymentDate],
                AMOUNT            as ![AmountPaid],
                CURRENCY_CODE     as ![CurrencyCode]
            }
            where
                paidBy.ID != '';

    define view ![MemberExpense] as
        select from transaction.member_expense {
            ID                                             as ![PaymentGuid],
            expenseNo                                      as ![PaymentNumber],
            tripId.tripId                                  as ![TripNumber],
            tripId.year                                    as ![Year],
            tripId.month                                   as ![Month],
            paidBy.memberName                              as ![PaidBy],
            member_expense_contributer.memberId.memberName as ![ContributerName],
            category.name                                  as ![Category],
            expenseDate                                    as ![ExpenseDate],
            noOfContributers                               as ![NoofContributers],
            AMOUNT                                         as ![TotalAmount],
            CURRENCY_CODE                                  as ![CurrencyCode],
            (
                AMOUNT / noOfContributers
            )                                              as ![PerHeadContribution]

        }

    define view ![TripExpense] as
        select from transaction.member_expense {
            ID                as ![PaymentGuid],
            expenseNo         as ![PaymentNumber],
            tripId.tripId     as ![TripNumber],
            tripId.year       as ![Year],
            tripId.month      as ![Month],
            paidBy.memberName as ![PaidBy],
            category.name     as ![Category],
            expenseDate       as ![ExpenseDate],
            noOfContributers  as ![NoofContributers],
            AMOUNT            as ![TotalAmount],
            CURRENCY_CODE     as ![CurrencyCode],
            (
                AMOUNT / noOfContributers
            )                 as ![PerHeadContribution]
        }

    define view ![MermberPaymentTotal] as
        select from MemberPayment {
            TripNumber,
            PaidBy,
            sum(AmountPaid) as AmountPaid,
            CurrencyCode
        }
        group by
            TripNumber,
            PaidBy,
            CurrencyCode;

    define view ![MemberExpenseTotal] as
        select from MemberExpense {
            TripNumber,
            ContributerName,
            sum(PerHeadContribution) as PerHeadContribution,
            CurrencyCode
        }
        group by
            TripNumber,
            ContributerName,
            CurrencyCode;
}
