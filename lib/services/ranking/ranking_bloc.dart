import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/repositories/ranking_repository.dart';
import 'package:equatable/equatable.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final RankingRepository rankingRepository;

  late StreamSubscription<List<Map<String, dynamic>>> _streamSubscription;

  RankingBloc({
    required this.rankingRepository,
  }) : super(const RankingInitialState()) {
    on<OnInitializeRankingEvent>((event, emit) {
      _streamSubscription = rankingRepository.getRanking().listen((rankings) {
        add(OnLoadedRankingEvent(
          rankings: rankings,
        ));
      });
    });

    on<OnUnsubscribeRankingEvent>((event, emit) {
      _streamSubscription.cancel();
    });

    on<OnLoadedRankingEvent>((event, emit) {
      emit(RankingInitialState(
        rankings: event.rankings,
      ));
    });
  }
}
