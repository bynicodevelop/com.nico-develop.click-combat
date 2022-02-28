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

// setInterval(() => scheduledCalculatePositions(), 1000)
exports.scheduledCalculatePositions = functions.pubsub
  .schedule("* * * * *")
  .onRun(async (context) => {
    const clicksOrdered = await admin
      .firestore()
      .collection("clicks")
      .orderBy("clicks", "desc")
      .get();

    for (let i = 0; i < clicksOrdered.size; i++) {
      const documentRef = clicksOrdered.docs[i];

      const { clicks, userRef } = documentRef.data();

      console.log(`${userRef.path} ${clicks}`);

      const userDocument = await userRef.get();

      const { ranking } = userDocument.data();

      const newRanking = ranking - (i + 1);

      await userRef.update({
        ranking: i + 1,
        newRanking,
      });
    }

    return null;
  });
