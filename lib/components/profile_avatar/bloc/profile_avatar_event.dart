part of 'profile_avatar_bloc.dart';

abstract class ProfileAvatarEvent extends Equatable {
  const ProfileAvatarEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateProfileAvatar extends ProfileAvatarEvent {
  final String avatar;

  const OnUpdateProfileAvatar({
    required this.avatar,
  });

  @override
  List<Object> get props => [
        avatar,
      ];
}
