sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'trippin.app.tripdetails',
            componentId: 'TripMembersObjectPage',
            contextPath: '/TripMaster/trip_members'
        },
        CustomPageDefinitions
    );
});