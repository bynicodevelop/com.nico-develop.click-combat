part of 'username_bloc.dart';

abstract class UsernameState extends Equatable {
  const UsernameState();

  @override
  List<Object> get props => [];
}

class UsernameInitialState extends UsernameState {}

class UsernameLoadingState extends UsernameState {}

class UsernameLoadedState extends UsernameState {}

class UsernameAlreadyExistsState extends UsernameState {}
