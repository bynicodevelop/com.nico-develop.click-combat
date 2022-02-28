const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { firestore } = require("firebase-admin");

admin.initializeApp();

exports.onUserCreated = functions.auth.user().onCreate((user) => {
  const { uid, email } = user;

  return admin.firestore().collection("users").doc(uid).set({
    email,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });
});

exports.onUserClicked = functions.firestore
  .document("users/{userId}")
  .onUpdate(async (change, context) => {
    const { userId } = context.params;
    const { before, after } = change;

    const beforeClick = before.data().clicks;
    const afterClick = after.data().clicks;

    if (afterClick - beforeClick == 0) return;

    var d = new Date();
    d.setHours(0, 0, 0, 0);

    const clickDocuments = await admin
      .firestore()
      .collection("clicks")
      .where("userRef", "==", admin.firestore().doc(`users/${userId}`))
      .where("date", "==", admin.firestore.Timestamp.fromDate(d))
      .limit(1)
      .get();

    if (clickDocuments.docs.length == 1) {
      const clickDocument = clickDocuments.docs[0];

      await clickDocument.ref.update({
        clicks: admin.firestore.FieldValue.increment(afterClick - beforeClick),
      });
    }
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
