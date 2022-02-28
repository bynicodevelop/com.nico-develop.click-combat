part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadedEvent extends ProfileEvent {
  final ProfileModel profileModel;

  const ProfileLoadedEvent({
    required this.profileModel,
  });

  @override
  List<Object> get props => [
        profileModel,
      ];
}
