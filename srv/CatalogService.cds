using {
    tripin.db.master,
    tripin.db.transaction
} from '../db/datamodel';


service CatalogService @(path: '/CatalogService') {

    entity TripMaster          as projection on master.trip_master;
    @Capabilities : { Insertable,Updatable,Deletable : false, }
    entity MemberMaster        as projection on master.memeber_master{
        *,
        trip_members : redirected to TripMembers ,
        member_payment : redirected to MemberPayment,
        member_expense_contributer : redirected to MemberExpenseContri
    }actions{
        function highestPayment() returns array of MemberMaster;
        action boost();
    };
    entity Category            as projection on master.category;
    entity TripMembers         as projection on master.trip_members;
    entity MemberPayment       as projection on transaction.member_payment;
    entity MemberExpense       as projection on transaction.member_expense{
        *,
        member_expense_contributer : redirected to MemberExpenseContri
    };
    entity MemberExpenseContri as projection on transaction.member_expense_contributer;
}
