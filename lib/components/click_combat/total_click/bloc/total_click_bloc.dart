import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/repositories/click_repository.dart';
import 'package:equatable/equatable.dart';

part 'total_click_event.dart';
part 'total_click_state.dart';

class TotalClickBloc extends Bloc<TotalClickEvent, TotalClickState> {
  final ClickRepository clickRepository;

  late StreamSubscription<Map<String, dynamic>> _clickSubscription;

  TotalClickBloc({
    required this.clickRepository,
  }) : super(const TotalClickInitialState()) {
    on<OnInitializeTotalClickEvent>((event, emit) {
      _clickSubscription = clickRepository.getClicks().listen((clicks) {
        add(OnTotalClickLoadedEvent(
          data: clicks,
          refresh: DateTime.now().microsecondsSinceEpoch,
        ));
      });
    });

    on<OnUnsubscribeTotalClickEvent>((event, emit) {
      _clickSubscription.cancel();
    });

    on<OnTotalClickLoadedEvent>((event, emit) {
      emit(TotalClickInitialState(
        data: event.data,
      ));
    });
  }
}
