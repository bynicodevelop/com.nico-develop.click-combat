import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/models/profile_model.dart';
import 'package:com_nico_develop_click_combat/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRespository profileRepository;

  ProfileBloc({
    required this.profileRepository,
  }) : super(ProfileInitialState()) {
    profileRepository.profile.listen((profileModel) {
      add(ProfileLoadedEvent(
        profileModel: profileModel,
      ));
    });

    on<ProfileLoadedEvent>((event, emit) {
      emit(ProfileLoadedState(
        profileModel: event.profileModel,
      ));
    });
  }
}
