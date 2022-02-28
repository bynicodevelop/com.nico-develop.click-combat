import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/repositories/ranking_repository.dart';
import 'package:equatable/equatable.dart';

part 'ranking_position_event.dart';
part 'ranking_position_state.dart';

class RankingPositionBloc
    extends Bloc<RankingPositionEvent, RankingPositionState> {
  final RankingRepository rankingRepository;

  RankingPositionBloc({
    required this.rankingRepository,
  }) : super(const RankingPositionInitialState()) {
    // rankingRepository.getUserRanking().listen((event) {
    //   add(OnUpdatedRankingPositionEvent(
    //     rankingPosition: event['newRanking'],
    //   ));
    // });

    on<OnUpdatedRankingPositionEvent>((event, emit) {
      emit(RankingPositionInitialState(
        rankingPosition: event.rankingPosition,
      ));
    });
  }
}
