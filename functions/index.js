const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require('express');
const app = express();


admin.initializeApp(functions.config().firebase);


let registrationToken = 'dyMyxjqhTk6-W3CuZtE6jV:APA91bHOVc7kR4iN9NKEOE_uy73IpsjJSHC21QL9U2SOK9m_W-RmrwuGGbsVjpDQF5Xofa3AAh5t8M0DVmnpmKEQBHr_aY_it7WOvGiV5QH5Viq7tRrdUwN3ZQizjZgEE83T6BvkllBf';


let message = {
    notification: {
        title: 'test',
        body: 'msg test1'
    },
    data: {
        score: '850',
        time: '2:45'
    },
    token: registrationToken
};

admin.messaging().send(message)
    .then((response) => {
        // Response is a message ID string.
        console.log('Successfully sent message:', response);
    })
    .catch((error) => {
        console.log('Error sending message:', error);
    });

app.get('/hello-world', (req, res) => {
    return res.status(200).send('Hello World!');
});

app.post('/api/create', (req, res) => {
    (async () => {
        try {
            await admin.firestore().collection('items').doc('/' + req.body.id + '/')
                .create({item: req.body.item});
            return res.status(200).send();
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
    })();
}).listen(process.env.PORT);

exports.app = functions.https.onRequest(app);
