import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String displayName;

  const ProfileModel({
    required this.displayName,
  });

  static fromSnapshot(Map<String, dynamic> snapshot) {
    return ProfileModel(
      displayName: snapshot['displayName'],
    );
  }

  bool isEmpty() => displayName.isEmpty;

  static ProfileModel empty() => const ProfileModel(
        displayName: "",
      );

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
    };
  }

  @override
  List<Object> get props => [
        displayName,
      ];
}
