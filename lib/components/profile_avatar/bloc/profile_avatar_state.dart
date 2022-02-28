part of 'profile_avatar_bloc.dart';

abstract class ProfileAvatarState extends Equatable {
  const ProfileAvatarState();

  @override
  List<Object> get props => [];
}

class ProfileAvatarInitialState extends ProfileAvatarState {
  final DrawableRoot? avatar;
  final int refresh;

  const ProfileAvatarInitialState({
    this.avatar,
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        refresh,
      ];
}
