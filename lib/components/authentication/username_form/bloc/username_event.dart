part of 'username_bloc.dart';

abstract class UsernameEvent extends Equatable {
  const UsernameEvent();

  @override
  List<Object> get props => [];
}

class OnSetUsernameEvent extends UsernameEvent {
  final String displayName;

  const OnSetUsernameEvent({
    required this.displayName,
  });

  @override
  List<Object> get props => [
        displayName,
      ];
}
