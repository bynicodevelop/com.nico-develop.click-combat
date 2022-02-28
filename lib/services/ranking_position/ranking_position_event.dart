part of 'ranking_position_bloc.dart';

abstract class RankingPositionEvent extends Equatable {
  const RankingPositionEvent();

  @override
  List<Object> get props => [];
}

class OnUpdatedRankingPositionEvent extends RankingPositionEvent {
  final int rankingPosition;

  const OnUpdatedRankingPositionEvent({
    required this.rankingPosition,
  });

  @override
  List<Object> get props => [
        rankingPosition,
      ];
}
