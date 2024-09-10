using {trippin.common.Amount} from '../db/common';
using {
    trippin.db.master,
    trippin.db.master.trip_members,
    trippin.db.transaction
} from '../db/datamodel';


service CatalogService @(path: '/CatalogService') {

    entity TripMaster @(odata.draft.enabled: true)   as
        projection on master.trip_master {
            *,
            trip_members : redirected to TripMembers
        };

    @Capabilities: {
        Insertable,
        Updatable,
        Deletable: false,
    }
    entity MemberMaster @(odata.draft.enabled: true) as
        projection on master.memeber_master {
            *,
            trip_members               : redirected to TripMembers,
            member_payment             : redirected to MemberPayment,
            member_expense_contributer : redirected to MemberExpenseContri
        }
        actions {
            function highestPayment() returns array of MemberMaster;
            action   boost();
        };

    entity Category                                  as projection on master.category;

    entity TripMembers @()                           as
        projection on master.trip_members {
            *,
            case active
                when
                    1
                then
                    'Active'
                when
                    0
                then
                    'Deactive'
            end as active      : String(10),
            case active
                when
                    1
                then
                    3
                when
                    0
                then
                    1
            end as Criticality : Integer,
        };

    entity MemberPayment                             as projection on transaction.member_payment;

    entity MemberExpense                             as
        projection on transaction.member_expense {
            *,
            member_expense_contributer : redirected to MemberExpenseContri
        };

    entity MemberExpenseContri                       as projection on transaction.member_expense_contributer;
}
