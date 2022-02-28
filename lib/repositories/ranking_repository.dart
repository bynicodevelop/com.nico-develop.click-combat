import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RankingRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth authentication;

  const RankingRepository({
    required this.firestore,
    required this.authentication,
  });

  Stream<List<Map<String, dynamic>>> getRanking() {
    return firestore
        .collection("clicks")
        .orderBy(
          'clicks',
          descending: true,
        )
        .limit(6)
        .snapshots()
        .asyncMap((snapshot) async {
      return (await Future.wait(snapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data();

        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await data["userRef"].get();

        return {
          ...doc.data(),
          'displayName': documentSnapshot.data()!['displayName'] ?? "",
        };
      })))
          .toList();
    });
  }

  Stream<Map<String, dynamic>> getUserRanking() {
    return firestore
        .collection("users")
        .doc(authentication.currentUser!.uid)
        .snapshots()
        .asyncMap((snapshot) async {
      Map<String, dynamic>? data = snapshot.data();

      return {
        ...data ?? {},
      };
    });
  }
}
