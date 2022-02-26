import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/exceptions/authentication_exception.dart';
import 'package:com_nico_develop_click_combat/repositories/authentication_respository.dart';
import 'package:equatable/equatable.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginBloc({
    required this.authenticationRepository,
  }) : super(LoginInitialState()) {
    on<OnLoginWithEmailPasswordEvent>((event, emit) async {
      emit(LoginLoadingState());

      try {
        await authenticationRepository.signInWithEmailAndPassword(
          event.email,
          event.password,
        );

        emit(LoginSuccessState());
      } on AuthenticationException catch (e) {
        emit(LoginFailureState(
          error: e.toString(),
        ));
      }
    });
  }
}
