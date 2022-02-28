import 'package:bloc/bloc.dart';
import 'package:com_nico_develop_click_combat/helpers/svc_wrapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';

part 'profile_avatar_event.dart';
part 'profile_avatar_state.dart';

class ProfileAvatarBloc extends Bloc<ProfileAvatarEvent, ProfileAvatarState> {
  Future<DrawableRoot> _generateSvgRoot(String id) async =>
      SvgWrapper(multiavatar(id)).generateLogo();

  ProfileAvatarBloc() : super(const ProfileAvatarInitialState()) {
    on<OnUpdateProfileAvatar>((event, emit) async {
      emit(ProfileAvatarInitialState(
        avatar: await _generateSvgRoot(
          event.avatar,
        ),
        refresh: DateTime.now().microsecondsSinceEpoch,
      ));
    });
  }
}
