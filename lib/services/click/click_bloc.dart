import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/repositories/click_repository.dart';
import 'package:equatable/equatable.dart';

part 'click_event.dart';
part 'click_state.dart';

class ClickBloc extends Bloc<ClickEvent, ClickState> {
  final ClickRepository clickRepository;

  ClickBloc({
    required this.clickRepository,
  }) : super(ClickInitialState()) {
    on<OnClickEvent>((event, emit) async {
      await clickRepository.addClick(
        event.value,
      );

      emit(ClickLoadedState(
        refresh: DateTime.now().microsecondsSinceEpoch,
      ));
    });
  }
}
