part of 'click_bloc.dart';

abstract class ClickEvent extends Equatable {
  const ClickEvent();

  @override
  List<Object> get props => [];
}

class OnClickEvent extends ClickEvent {
  final int value;

  const OnClickEvent({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}

class OnClickLoadedEvent extends ClickEvent {
  final Map<String, dynamic> value;

  const OnClickLoadedEvent({
    required this.value,
  });

  @override
  List<Object> get props => [
        value,
      ];
}
