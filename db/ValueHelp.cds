namespace trippin.db;

using {trippin.db.master} from './datamodel.cds';

context ValueHelp {
    define view TripVH as
        select from master.trip_master {
            ID          as ![TripID],
            tripId      as ![TripNumber],
            description as ![Description]
        }

    annotate TripVH with {
        TripID      @title: '{i18n>trip_master_id}';
        TripNumber  @title: '{i18n>trip_id}';
        Description @title: '{i18n>description}';
    };

    define view MemberVH as
        select from master.memeber_master {
            ID         as ![MemberID],
            memberName as ![MemberName]
        }

    annotate MemberVH with {
        MemberID   @title: '{i18n>member_master_id}';
        MemberName @title: '{i18n>member_name}';
    };

    define view CategoryVH as
        select from master.category {
            ID   as ![CategoryID],
            name as ![CategoryName]
        }

    annotate CategoryVH with {
        CategoryID   @title: '{i18n>category_id}';
        CategoryName @title: '{i18n>category_name}';
    };


}
