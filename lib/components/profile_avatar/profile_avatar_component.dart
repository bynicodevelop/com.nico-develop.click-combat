import 'package:com_nico_develop_click_combat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:com_nico_develop_click_combat/helpers/svc_wrapper.dart';
import 'package:com_nico_develop_click_combat/widgets/svg_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';

class ProfileAvatarComponent extends StatelessWidget {
  const ProfileAvatarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileAvatarBloc, ProfileAvatarState>(
      builder: (context, state) {
        if ((state as ProfileAvatarInitialState).avatar == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SvgAvatar(
          svgRoot: (state).avatar!,
        );
      },
    );
  }
}
