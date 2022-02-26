import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/models/user_model.dart';
import 'package:com_nico_develop_click_combat/repositories/authentication_respository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthenticationRepository authenticationRepository;

  UserBloc({
    required this.authenticationRepository,
  }) : super(UserInitialState()) {
    authenticationRepository.user.listen((UserModel userModel) {
      print("UserModel: ${userModel.toJson()}");
      add(OnUserLoadedEvent(
        userModel: userModel,
      ));
    });

    on<OnUserLoadedEvent>((event, emit) {
      emit(UserLoadedState(
        user: event.userModel,
      ));
    });
  }
}
