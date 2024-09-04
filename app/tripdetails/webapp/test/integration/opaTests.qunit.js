sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'trippin/app/tripdetails/test/integration/FirstJourney',
		'trippin/app/tripdetails/test/integration/pages/TripMasterList',
		'trippin/app/tripdetails/test/integration/pages/TripMasterObjectPage',
		'trippin/app/tripdetails/test/integration/pages/TripMembersObjectPage'
    ],
    function(JourneyRunner, opaJourney, TripMasterList, TripMasterObjectPage, TripMembersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('trippin/app/tripdetails') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheTripMasterList: TripMasterList,
					onTheTripMasterObjectPage: TripMasterObjectPage,
					onTheTripMembersObjectPage: TripMembersObjectPage
                }
            },
            opaJourney.run
        );
    }
);