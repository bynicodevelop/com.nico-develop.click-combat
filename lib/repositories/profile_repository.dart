import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_nico_develop_click_combat/exceptions/already_exists_exception.dart';
import 'package:com_nico_develop_click_combat/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRespository {
  final FirebaseAuth authentication;
  final FirebaseFirestore firestore;

  const ProfileRespository({
    required this.authentication,
    required this.firestore,
  });

  Stream<ProfileModel> get profile {
    return firestore
        .collection("users")
        .doc(authentication.currentUser!.uid)
        .snapshots()
        .map(
          (snapshot) => ProfileModel.fromSnapshot(
            snapshot.data() ?? {},
          ),
        );
  }

  Future<void> updateDisplayName(String displayName) async {
    QuerySnapshot querySnapshot = await firestore
        .collection("users")
        .where(
          "displayName",
          isEqualTo: displayName,
        )
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      throw AlreadyExistsException();
    }

    await authentication.currentUser!.updateDisplayName(displayName);

    await firestore
        .collection("users")
        .doc(authentication.currentUser!.uid)
        .update({
      "displayName": displayName,
    });
  }
}
