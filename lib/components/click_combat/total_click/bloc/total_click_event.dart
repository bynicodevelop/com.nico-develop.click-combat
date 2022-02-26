part of 'total_click_bloc.dart';

abstract class TotalClickEvent extends Equatable {
  const TotalClickEvent();

  @override
  List<Object> get props => [];
}

class OnTotalClickLoadedEvent extends TotalClickEvent {
  final Map<String, dynamic> data;
  final int refresh;

  const OnTotalClickLoadedEvent({
    required this.data,
    required this.refresh,
  });

  @override
  List<Object> get props => [
        data,
        refresh,
      ];
}

class OnInitializeTotalClickEvent extends TotalClickEvent {}

class OnUnsubscribeTotalClickEvent extends TotalClickEvent {}
