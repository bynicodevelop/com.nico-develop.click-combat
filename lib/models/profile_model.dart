import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String displayName;
  final int clicks;
  final int victories;

  const ProfileModel({
    required this.displayName,
    required this.clicks,
    required this.victories,
  });

  static fromSnapshot(Map<String, dynamic> snapshot) {
    return ProfileModel(
      displayName: snapshot['displayName'] ?? "",
      clicks: snapshot['clicks'] ?? 0,
      victories: snapshot['victories'] ?? 0,
    );
  }

  bool isEmpty() => displayName.isEmpty;

  static ProfileModel empty() => const ProfileModel(
        displayName: "",
        clicks: 0,
        victories: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'clicks': clicks,
      'victories': victories,
    };
  }

  @override
  List<Object> get props => [
        displayName,
        clicks,
        victories,
      ];
}
