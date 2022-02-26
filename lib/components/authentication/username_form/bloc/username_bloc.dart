import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'username_event.dart';
part 'username_state.dart';

class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  final ProfileRespository profileRepository;

  UsernameBloc({
    required this.profileRepository,
  }) : super(UsernameInitialState()) {
    on<OnSetUsernameEvent>((event, emit) async {
      emit(UsernameLoadingState());

      await profileRepository.updateDisplayName(
        event.displayName,
      );

      emit(UsernameLoadedState());
    });
  }
}
