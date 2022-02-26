import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRespository {
  final FirebaseAuth authentication;
  final FirebaseFirestore firestore;

  const ProfileRespository({
    required this.authentication,
    required this.firestore,
  });

  Future<void> updateDisplayName(String displayName) async {
    await firestore
        .collection("users")
        .doc(authentication.currentUser!.uid)
        .update({
      "displayName": displayName,
    });
  }
}
