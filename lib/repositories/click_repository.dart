import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClickRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth authentication;

  const ClickRepository({
    required this.firestore,
    required this.authentication,
  });

  DateTime _getDayDateTime() {
    final now = DateTime.now().toUtc();

    final lastMidnight = now.subtract(
      Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond,
      ),
    );

    return lastMidnight;
  }

  Stream<Map<String, dynamic>> getClicks() {
    return firestore
        .collection('clicks')
        .where(
          'userRef',
          isEqualTo: firestore.doc('users/${authentication.currentUser!.uid}'),
        )
        .where(
          'date',
          isEqualTo: _getDayDateTime(),
        )
        .snapshots()
        .map((snapshot) {
      final List<Map<String, dynamic>> clicks = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      return clicks.isNotEmpty ? clicks.first : {};
    });
  }

  Future<void> addClick(
    int clicks,
  ) async {
    final userRef =
        await firestore.doc('users/${authentication.currentUser!.uid}').get();

    if (userRef.exists) {
      await firestore
          .collection("users")
          .doc(authentication.currentUser!.uid)
          .update({
        'clicks': FieldValue.increment(clicks),
      });
    } else {
      await firestore
          .collection("users")
          .doc(authentication.currentUser!.uid)
          .set({
        'clicks': clicks,
      });
    }
  }
}
