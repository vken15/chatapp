var admin = require("firebase-admin");

var serviceAccount = require(".../config/push-notification-key.json");
const certPath = admin.credential.cert(serviceAccount);
//var fcm = new fcm(certPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});