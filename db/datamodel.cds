namespace trippin.db;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {trippin.common} from './common';


context master {

    entity trip_master : cuid, managed {
        tripno         : String(10);
        year           : Integer;
        month          : Integer;
        description    : String(50);
        location       : String(50);
        itinerary      : LargeString;
        noOfMembers    : Integer;
        trip_members   : Composition of many trip_members
                             on trip_members.tripId = $self;
        member_payment : Association to many transaction.member_payment
                             on member_payment.tripId = $self;
        member_expense : Association to many transaction.member_expense
                             on member_expense.tripId = $self;
    }

    annotate trip_master with {
        ID          @title: '{i18n>trip_master_id}';
        tripno      @title: '{i18n>trip_no}';
        year        @title: '{i18n>year}';
        month       @title: '{i18n>month}';
        description @title: '{i18n>description}';
        location    @title: '{i18n>location}';
        itinerary   @title: '{i18n>itinerary}';
        noOfMembers @title: '{i18n>no_of_members}'
    };


    entity memeber_master : cuid, managed {
        memberName                 : String(60);
        phoneNo                    : common.PhoneNumber null;
        email                      : common.Email;
        dob                        : Date;
        gender                     : common.Gender;
        trip_members               : Association to many trip_members
                                         on trip_members.memberId = $self;
        member_payment             : Association to many transaction.member_payment
                                         on member_payment.memberId = $self;
        member_expense_contributer : Association to many transaction.member_expense_contributer
                                         on member_expense_contributer.memberId = $self;
    }

    annotate memeber_master with {
        ID         @title: '{i18n>member_master_id}';
        memberName @title: '{i18n>member_name}';
        phoneNo    @title: '{i18n>phone}';
        email      @title: '{i18n>email}';
        dob        @title: '{i18n>dob}';
        gender     @title: '{i18n>gender}';
    };


    entity category : cuid, managed {
        name           : String(50);
        member_expense : Association to many transaction.member_expense
                             on member_expense.category = $self;
    }

    annotate category with {
        ID   @title: '{i18n>category_id}';
        name @title: '{i18n>category_name}';
    };


    entity trip_members : cuid, managed {
        tripId   : Association to one trip_master;
        memberId : Association to one memeber_master;
        active   : Boolean;
    }

    annotate trip_members with {
        ID       @title: '{i18n>trip_members_id}';
        tripId   @title: '{i18n>trip_master_id}';
        memberId @title: '{i18n>member_master_id}';
        active   @title: '{i18n>active}';
    };


}

context transaction {

    entity member_payment : cuid, managed, common.Amount {
        paymentNo   : String(10);
        tripId      : Association to one master.trip_master;
        memberId    : Association to one master.memeber_master;
        paymentDate : Date;
    }

    annotate member_payment with {
        ID          @title: '{i18n>member_payment_id}';
        paymentNo   @title: '{i18n>payment_no}';
        tripId      @title: '{i18n>trip_master_id}';
        memberId    @title: '{i18n>member_master_id}';
        paymentDate @title: '{i18n>payment_date}';
    };


    entity member_expense : cuid, managed, common.Amount {
        expenseNo                  : String(10);
        tripId                     : Association to one master.trip_master;
        paidBy                     : Association to one master.memeber_master;
        category                   : Association to one master.category;
        expenseDate                : Date;
        noOfContributers           : Integer;
        member_expense_contributer : Composition of many member_expense_contributer
                                         on member_expense_contributer.memberExpenseId = $self
    }

    annotate member_expense with {
        ID               @title: '{i18n>member_expense_id}';
        expenseNo        @title: '{i18n>expense_no}';
        tripId           @title: '{i18n>trip_master_id}';
        paidBy           @title: '{i18n>member_master_id}';
        category         @title: '{i18n>category_id}';
        expenseDate      @title: '{i18n>expense_date}';
        noOfContributers @title: '{i18n>no_of_contributers}';
    };


    entity member_expense_contributer : cuid, managed {
        memberExpenseId : Association to one member_expense;
        memberId        : Association to master.memeber_master;
    }

    annotate member_expense_contributer with {
        ID              @title: '{i18n>member_expense_contributer_id}';
        memberExpenseId @title: '{i18n>member_expense_id}';
        memberId        @title: '{i18n>member_master_id}';
    };


}
