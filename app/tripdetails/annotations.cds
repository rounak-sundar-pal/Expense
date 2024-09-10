using CatalogService as service from '../../srv/CatalogService';
using {ValueHelpService} from '../../srv/ValueHelpService';

// annotate service.TripMaster with {
//     ID@(
//         Comm
//     )
// } ;


annotate service.TripMaster with @(
    UI.TextArrangement       : #TextOnly,
    cds.odata.valuelist,
    UI.SelectionFields       : [
        tripno,
        month,
        year,
        location,
    ],
    UI.LineItem              : [
        {
            $Type: 'UI.DataField',
            Value: tripno,
        },
        {
            $Type: 'UI.DataField',
            Value: year,
        },
        {
            $Type: 'UI.DataField',
            Value: month,
        },
        {
            $Type: 'UI.DataField',
            Value: description,
        },
        {
            $Type: 'UI.DataField',
            Value: location,
        },
    ],
    UI.HeaderInfo            : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>TripDetail}',
        TypeNamePlural: '{i18n>TripDetails}',
        Title         : {
            Label: '{i18n>TripNo}',
            Value: tripno
        },
        Description   : {
            Label: '{i18n>description}',
            Value: description
        },
        ImageUrl      : 'https://oddessemania.in/wp-content/uploads/2023/08/Wei-sawding-oddessemabnia-1024x768.jpg'
    },
    UI.Facets                : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Trip Details',
            Target: ![@UI.FieldGroup#HeaderInfo]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Trip Members',
            Target: 'trip_members/@UI.LineItem',
        },
    ],

    UI.FieldGroup #HeaderInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: tripno,
            },
            {
                $Type: 'UI.DataField',
                Value: year,
            },
            {
                $Type: 'UI.DataField',
                Value: month,
            },
            {
                $Type: 'UI.DataField',
                Value: description,
            },
            {
                $Type: 'UI.DataField',
                Value: location,
            },
            {
                $Type: 'UI.DataField',
                Value: noOfMembers,
            },
            {
                $Type: 'UI.DataField',
                Value: itinerary,
            },
        ],
    }

) {
    tripno @(
        title : 'Trip Number',
        Common: {ValueList: {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'TripMaster',
            SearchSupported: true,
            Parameters     : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: tripno,
                    ValueListProperty: 'tripno',
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: description,
                    ValueListProperty: 'description',
                },
            ]
        }, }
    );
    year   @(
        title : 'Year',
        Common: {ValueList: {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'TripMaster',
            SearchSupported: true,
            Parameters     : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: year,
                ValueListProperty: 'year',
            }, ]
        },

        }
    )
};


annotate service.TripMembers with @(UI: {
    LineItem              : [
        {
            $Type: 'UI.DataField',
            Value: tripId.ID,
        },
        {
            $Type: 'UI.DataField',
            Value: tripId.tripno,
        },
        {
            $Type: 'UI.DataField',
            Value: memberId.ID,
        },
        {
            $Type: 'UI.DataField',
            Value: memberId.memberName,
        },
        {
            $Type                    : 'UI.DataField',
            Value                    : active,
            Criticality              : Criticality,
            CriticalityRepresentation: #WithIcon
        },
    ],
    HeaderInfo            : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Trip Member',
        TypeNamePlural: 'Trip Members',
        Title         : {
            $Type: 'UI.DataField',
            Value: memberId.memberName,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: active
        }
    },
    Facets                : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Trip Details',
        Target: ![@UI.FieldGroup#MemberInfo]
    }, ],
    FieldGroup #MemberInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: memberId.ID,
            },
            {
                $Type: 'UI.DataField',
                Value: memberId.memberName,
            },
            {
                $Type: 'UI.DataField',
                Value: memberId.phoneNo,
            },
            {
                $Type: 'UI.DataField',
                Value: memberId.email,
            },
        ]
    },
}) {


    memberId @(
        title : 'Member GUID',
        Common: {ValueList: {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'MemberMaster',
            SearchSupported: true,
            Parameters     : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: memberId.ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: memberId.memberName,
                    ValueListProperty: 'memberName',
                },
            ]

        }, }
    )
};

annotate service.MemberMaster with {
    ID @(
        title : 'Member GUID',
        Common: {ValueList: {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'MemberMaster',
            SearchSupported: true,
            Parameters     : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: memberName,
                    ValueListProperty: 'memberName',
                },
            ]
        }, }
    )
};
