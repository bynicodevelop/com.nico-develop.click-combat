const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.onUserCreated = functions.auth.user().onCreate((user) => {
  const { uid, email } = user;

  return admin.firestore().collection("users").doc(uid).set({
    email,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
});
