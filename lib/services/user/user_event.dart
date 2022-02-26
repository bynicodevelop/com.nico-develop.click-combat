part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class OnInitializeEvent extends UserEvent {}

class OnUserLoadedEvent extends UserEvent {
  final UserModel userModel;

  const OnUserLoadedEvent({
    required this.userModel,
  });

  @override
  List<Object> get props => [
        userModel,
      ];
}
