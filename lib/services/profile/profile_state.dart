part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profileModel;

  const ProfileLoadedState({required this.profileModel});

  @override
  List<Object> get props => [
        profileModel,
      ];
}

class ProfileErrorState extends ProfileState {}
