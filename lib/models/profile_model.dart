import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String displayName;
  final int clicks;

  const ProfileModel({
    required this.displayName,
    required this.clicks,
  });

  static fromSnapshot(Map<String, dynamic> snapshot) {
    return ProfileModel(
      displayName: snapshot['displayName'],
      clicks: snapshot['clicks'],
    );
  }

  bool isEmpty() => displayName.isEmpty;

  static ProfileModel empty() => const ProfileModel(
        displayName: "",
        clicks: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'clicks': clicks,
    };
  }

  @override
  List<Object> get props => [
        displayName,
        clicks,
      ];
}
