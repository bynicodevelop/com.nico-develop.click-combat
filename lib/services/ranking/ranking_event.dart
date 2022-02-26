part of 'ranking_bloc.dart';

abstract class RankingEvent extends Equatable {
  const RankingEvent();

  @override
  List<Object> get props => [];
}

class OnInitializeRankingEvent extends RankingEvent {}

class OnUnsubscribeRankingEvent extends RankingEvent {}

class OnLoadedRankingEvent extends RankingEvent {
  final List<Map<String, dynamic>> rankings;

  const OnLoadedRankingEvent({
    required this.rankings,
  });

  @override
  List<Object> get props => [
        rankings,
      ];
}
