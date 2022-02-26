part of 'click_bloc.dart';

abstract class ClickState extends Equatable {
  const ClickState();

  @override
  List<Object> get props => [];
}

class ClickInitialState extends ClickState {}

class ClickLoadingState extends ClickState {}

class ClickLoadedState extends ClickState {
  final int refresh;

  const ClickLoadedState({
    required this.refresh,
  });

  @override
  List<Object> get props => [
        refresh,
      ];
}
