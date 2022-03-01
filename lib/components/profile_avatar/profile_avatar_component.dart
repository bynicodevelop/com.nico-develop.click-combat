import 'package:com_nico_develop_click_combat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:com_nico_develop_click_combat/helpers/svc_wrapper.dart';
import 'package:com_nico_develop_click_combat/widgets/svg_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiavatar/multiavatar.dart';

class ProfileAvatarComponent extends StatelessWidget {
  final double paddingDelta;
  final double size;
  const ProfileAvatarComponent({
    Key? key,
    this.paddingDelta = 0,
    this.size = 180,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileAvatarBloc, ProfileAvatarState>(
      builder: (context, state) {
        if ((state as ProfileAvatarInitialState).avatar == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal:
                (MediaQuery.of(context).size.width - size - paddingDelta) / 2,
          ),
          height: size + 20,
          width: double.infinity,
          child: SvgAvatar(
            svgRoot: (state).avatar!,
            paddingDelta: paddingDelta,
          ),
        );
      },
    );
  }
}
