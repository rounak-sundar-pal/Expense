namespace trippin.db;

using {trippin.db.transaction, trippin.db.master} from './datamodel.cds';

context CDSViews {
    define view ![MemberPayment] as
            select from transaction.member_payment {
                ID                  as ![PaymentGuid],
                paymentNo           as ![PaymentNumber],
                tripId.tripId       as ![TripNumber],
                tripId.year         as ![Year],
                tripId.month        as ![Month],
                memberId.ID         as ![PaidById],
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
                paidBy.ID         as ![PaidById],
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
            paidBy.ID                                      as ![PaidById],
            paidBy.memberName                              as ![PaidBy],
            member_expense_contributer.memberId.ID         as ![ContributerId],
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
            paidBy.ID         as ![PaidById],
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

    define view ![MemberPaymentTotal] as
        select from MemberPayment {
            TripNumber,
            PaidById,
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
            ContributerId,
            ContributerName,
            sum(PerHeadContribution) as PerHeadContribution,
            CurrencyCode
        }
        group by
            TripNumber,
            ContributerName,
            CurrencyCode;

    // define view ![MemberBalance] as
    //     select from master.trip_members as _TRIP_MEMBERS 
    //     left join MemberExpenseTotal as _Member_Expense
    //     on _TRIP_MEMBERS.memberId = _Member_Expense.ContributerId
            // _TRIP_MEMBERS.tripId = _Member_Expense.TripNumber
        // and _TRIP_MEMBERS.memberId = _Member_Expense.ContributerId
        // left outer join MemberPaymentTotal as _Member_Payment
        // on _TRIP_MEMBERS.tripId = _Member_Payment.TripNumber
        // and _TRIP_MEMBERS.memberId = _Member_Payment.PaidById 
        // {
            // _TRIP_MEMBERS.tripId,
            // _TRIP_MEMBERS.memberId,
            // _Member_Expense.ContributerName,
            // _Member_Expense.CurrencyCode,
            // _Member_Expense.PerHeadContribution,
            // _Member_Payment.AmountPaid,
            // ( _Member_Expense.PerHeadContribution - _Member_Payment.AmountPaid ) as Balance
        // }
        
}

