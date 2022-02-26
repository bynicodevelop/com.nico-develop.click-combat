part of 'total_click_bloc.dart';

abstract class TotalClickState extends Equatable {
  const TotalClickState();

  @override
  List<Object> get props => [];
}

class TotalClickInitialState extends TotalClickState {
  final Map<String, dynamic> data;

  const TotalClickInitialState({
    this.data = const {"clicks": 0},
  });

  @override
  List<Object> get props => [
        data,
      ];
}
