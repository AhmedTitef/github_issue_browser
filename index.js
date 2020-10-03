const functions = require('firebase-functions');
const admin = require ('firebase-admin');
admin.initializeApp(functions.config().functions);



exports.sendToTopic = functions.firestore.document('rooms/{roomsId}/{roomsCollection}/{alerts}')
.onCreate(async (snapshot, context) =>

    {
    	const doc = snapshot.data();
    	const anAlert = doc.roomName;
    	const senderUID = doc.myUid;

    	console.log('staaaaaaart here');

    	console.log('alertttt:   ', anAlert);

   //  	admin.firestore().collection('rooms/{${anAlert}/${anAlert}').onCreate(async (snapshot , context)=>
   //  	{
			
			// var payload = {
   //          	notification: {title: 'COPS NEAR!' , body: 'SLOW DOWN MAN'},
   //          	data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'}
   //       };


   //       const response = await admin.messaging().sendToTopic(${anAlert} , payload);
   //       return response;

   //  	)};



var payload = {
            	notification: {title: 'COPS NEAR!' , body: 'SLOW DOWN MAN'},
            	data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'}
         };

           const response = await admin.messaging().sendToTopic(anAlert , payload);
        


            


   return response;
    });