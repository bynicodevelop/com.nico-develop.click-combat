part of 'ranking_bloc.dart';

abstract class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object> get props => [];
}

class RankingInitialState extends RankingState {
  final List<Map<String, dynamic>> rankings;

  const RankingInitialState({
    this.rankings = const [],
  });

  @override
  List<Object> get props => [
        rankings,
      ];
}
