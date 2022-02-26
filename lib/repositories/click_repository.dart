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
    QuerySnapshot querySnapshot = await firestore
        .collection('clicks')
        .where(
          'userRef',
          isEqualTo: firestore.doc('users/${authentication.currentUser!.uid}'),
        )
        .where(
          'date',
          isEqualTo: _getDayDateTime(),
        )
        .get();

    if (querySnapshot.size == 0) {
      await firestore.collection('clicks').add({
        'userRef': firestore.doc('users/${authentication.currentUser!.uid}'),
        'clicks': clicks,
        'date': _getDayDateTime(),
      });
    } else {
      final doc = querySnapshot.docs.first;

      await doc.reference.update({
        'clicks': FieldValue.increment(clicks),
      });
    }
  }
}
