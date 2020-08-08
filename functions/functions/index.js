const functions = require('firebase-functions');

const admin = require('firebase-admin')
admin.initializeApp()

exports.sendNotification = functions.firestore
    .document("usuarios/{user}/notifications/{notification}")
    .onCreate(async (snapshot, context) => {

        try {
            const notificationDocument = snapshot.data()

            const uid = context.params.user;

            const notificationMessage = notificationDocument.message;
            const notificationTitle = notificationDocument.title;

            const userDoc = await admin.firestore().collection("usuarios").doc(uid).get();

            const fcmToken = userDoc.data().fcmToken

            const message = {
                "notification": {
                    "title": notificationTitle,
                    "body": notificationMessage,
                },
                "data": {
                    "click_action": 'FLUTTER_NOTIFICATION_CLICK',
                    "icon": 'https://firebasestorage.googleapis.com/v0/b/meetby-d42fa.appspot.com/o/images%2FiconNot.png?alt=media&token=fe341454-66c1-4e63-8c93-d5747ccdf906'
                },
                "token": fcmToken
            }

            //send notification

            return admin.messaging().send(message)


        } catch (error) {
            console.log(error)
        }

    })
