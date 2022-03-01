const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { firestore } = require("firebase-admin");

admin.initializeApp();

exports.onUserCreated = functions.auth.user().onCreate((user) => {
  const { uid, email, displayName } = user;

  return admin
    .firestore()
    .collection("users")
    .doc(uid)
    .set({
      email,
      displayName: displayName || "",
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

    if (clickDocuments.docs.length == 0) {
      await admin
        .firestore()
        .collection("clicks")
        .add({
          clicks: afterClick,
          userRef: admin.firestore().doc(`users/${userId}`),
          date: admin.firestore.Timestamp.fromDate(d),
        });
    } else {
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

if (process.env.FUNCTIONS_EMULATOR) {
  exports.generateUsers = functions.https.onRequest(async (req, res) => {
    const users = [
      {
        email: "jeff1@domain.tld",
        password: "123456",
        displayName: "Jeff 1",
      },
      {
        email: "jeff2@domain.tld",
        password: "123456",
        displayName: "Jeff 2",
      },
      {
        email: "jeff3@domain.tld",
        password: "123456",
        displayName: "Jeff 3",
      },
      {
        email: "jeff4@domain.tld",
        password: "123456",
        displayName: "Jeff 4",
      },
    ];

    for (let i = 0; i < users.length; i++) {
      const { email, password, displayName } = users[i];
      console.log({ email, password, displayName });

      await admin.auth().createUser({ email, password, displayName });
    }

    res.send("Done");
  });
}
