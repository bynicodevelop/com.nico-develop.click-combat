import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_nico_develop_click_combat/components/authentication/forgotten_form/bloc/forgotten_form_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/login_form/bloc/login_form_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/logout_button/bloc/logout_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/register_form/bloc/register_form_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/username_form/bloc/username_bloc.dart';
import 'package:com_nico_develop_click_combat/components/click_combat/total_click/bloc/total_click_bloc.dart';
import 'package:com_nico_develop_click_combat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:com_nico_develop_click_combat/repositories/authentication_respository.dart';
import 'package:com_nico_develop_click_combat/repositories/click_repository.dart';
import 'package:com_nico_develop_click_combat/repositories/profile_repository.dart';
import 'package:com_nico_develop_click_combat/repositories/ranking_repository.dart';
import 'package:com_nico_develop_click_combat/services/click/click_bloc.dart';
import 'package:com_nico_develop_click_combat/services/profile/profile_bloc.dart';
import 'package:com_nico_develop_click_combat/services/ranking/ranking_bloc.dart';
import 'package:com_nico_develop_click_combat/services/ranking_position/ranking_position_bloc.dart';
import 'package:com_nico_develop_click_combat/services/user/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Provider extends StatelessWidget {
  final Widget child;
  final FirebaseAuth authentication;
  final FirebaseFirestore firestore;

  const Provider({
    Key? key,
    required this.child,
    required this.authentication,
    required this.firestore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository(
      authentication: authentication,
    );

    final ClickRepository clickRepository = ClickRepository(
      firestore: firestore,
      authentication: authentication,
    );

    final RankingRepository rankingRepository = RankingRepository(
      firestore: firestore,
      authentication: authentication,
    );

    final ProfileRespository profileRepository = ProfileRespository(
      firestore: firestore,
      authentication: authentication,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          lazy: false,
          create: (context) => UserBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<LoginBloc>(
          lazy: false,
          create: (context) => LoginBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<RegisterFormBloc>(
          create: (context) => RegisterFormBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<ForgottenFormBloc>(
          create: (context) => ForgottenFormBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<LogoutBloc>(
          create: (context) => LogoutBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<ClickBloc>(
          lazy: false,
          create: (context) => ClickBloc(
            clickRepository: clickRepository,
          ),
        ),
        BlocProvider<TotalClickBloc>(
          lazy: false,
          create: (context) => TotalClickBloc(
            clickRepository: clickRepository,
          ),
        ),
        BlocProvider<RankingBloc>(
          lazy: false,
          create: (context) => RankingBloc(
            rankingRepository: rankingRepository,
          ),
        ),
        BlocProvider<RankingPositionBloc>(
          lazy: false,
          create: (context) => RankingPositionBloc(
            rankingRepository: rankingRepository,
          ),
        ),
        BlocProvider<UsernameBloc>(
          lazy: false,
          create: (context) => UsernameBloc(
            profileRepository: profileRepository,
          ),
        ),
        BlocProvider<ProfileBloc>(
          lazy: false,
          create: (context) => ProfileBloc(
            profileRepository: profileRepository,
          ),
        ),
        BlocProvider<ProfileAvatarBloc>(
          create: (context) => ProfileAvatarBloc()
            ..add(
              const OnUpdateProfileAvatar(
                avatar: "click-combat",
              ),
            ),
        ),
      ],
      child: child,
    );
  }
}
