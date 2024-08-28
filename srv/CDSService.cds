using {tripin.db.CDSViews} from '../db/CDSViews';

service CDSService @(path: '/CDSService') {
    @readonly
    entity MemberPayment      as projection on CDSViews.MemberPayment;
    @readonly
    entity MemberExpense      as projection on CDSViews.MemberExpense;
    @readonly
    entity TripExpense        as projection on CDSViews.TripExpense;
    @readonly
    entity MemberPaymentTotal as projection on CDSViews.MermberPaymentTotal;
    @readonly
    entity MemberExpenseTotal as projection on CDSViews.MemberExpenseTotal;
}
