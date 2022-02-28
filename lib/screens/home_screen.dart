import 'package:com_nico_develop_click_combat/models/user_model.dart';
import 'package:com_nico_develop_click_combat/screens/profile_screen.dart';
import 'package:com_nico_develop_click_combat/screens/ranking_screen.dart';
import 'package:com_nico_develop_click_combat/screens/click_combat_screen.dart';
import 'package:com_nico_develop_click_combat/services/ranking_position/ranking_position_bloc.dart';
import 'package:com_nico_develop_click_combat/services/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          UserModel userModel = UserModel.empty();

          if (state is UserLoadedState) {
            userModel = state.user;
          }

          return BlocListener<RankingPositionBloc, RankingPositionState>(
            listener: (context, state) {
              String message = "";

              final int rankingPosition =
                  (state as RankingPositionInitialState).rankingPosition;

              if (rankingPosition > 0) {
                message = "Vous avez gagné $rankingPosition place";
              } else if (rankingPosition < 0) {
                message = "Vous avez perdu ${-rankingPosition} place";
              }

              if (message.isEmpty) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            },
            child: PageView(
              controller: _pageController,
              physics: userModel.isEmpty
                  ? const NeverScrollableScrollPhysics()
                  : null,
              children: [
                const ProfileScreen(),
                ClickCombatScreen(
                  userModel: userModel,
                ),
                const RankingScreen(),
              ],
            ),
          );
        },
      ),
    );
  }
}
