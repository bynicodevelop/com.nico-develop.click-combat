part of 'ranking_position_bloc.dart';

abstract class RankingPositionState extends Equatable {
  const RankingPositionState();

  @override
  List<Object> get props => [];
}

class RankingPositionInitialState extends RankingPositionState {
  final int rankingPosition;

  const RankingPositionInitialState({
    this.rankingPosition = 0,
  });

  @override
  List<Object> get props => [
        rankingPosition,
      ];
}
