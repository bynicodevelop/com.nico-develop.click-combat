import 'dart:async';
import 'dart:math';

import 'package:com_nico_develop_click_combat/components/authentication/login_form/bloc/login_form_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/logout_button/bloc/logout_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/register_form/bloc/register_form_bloc.dart';
import 'package:com_nico_develop_click_combat/components/click_combat/total_click/bloc/total_click_bloc.dart';
import 'package:com_nico_develop_click_combat/components/click_combat/total_click/total_click_component.dart';
import 'package:com_nico_develop_click_combat/configs/constants.dart';
import 'package:com_nico_develop_click_combat/models/user_model.dart';
import 'package:com_nico_develop_click_combat/screens/auth_screen.dart';
import 'package:com_nico_develop_click_combat/services/click/click_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickCombatScreen extends StatefulWidget {
  final UserModel userModel;

  const ClickCombatScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ClickCombatScreen> createState() => _ClickCombatScreenState();
}

class _ClickCombatScreenState extends State<ClickCombatScreen> {
  int _countdown = 3;
  int _increment = 0;
  bool _countdownStarted = false;
  bool _isPlaying = false;

  Timer? _debounce;

  Future<void> _startCountdown() async {
    setState(() {
      _countdown = 3;
      _countdownStarted = true;
    });

    Timer.periodic(
        const Duration(
          milliseconds: 700,
        ), (Timer timer) async {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();

        setState(() {
          _isPlaying = true;
        });
      }
    });
  }

  _saveClicks() => context.read<ClickBloc>().add(
        OnClickEvent(
          value: _increment,
        ),
      );

  _onClick(bool isAuthenticated) {
    setState(() => _increment++);

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(
        const Duration(
          milliseconds: 500,
        ), () {
      if (isAuthenticated) {
        _saveClicks();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return const AuthScreen();
            },
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (!widget.userModel.isEmpty) {
      context.read<TotalClickBloc>().add(OnInitializeTotalClickEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (contact, state) {
        if (state is LogoutSuccessState) {
          // Déconnecté
          context.read<TotalClickBloc>().add(OnUnsubscribeTotalClickEvent());
        }
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            // Save in database
            context.read<TotalClickBloc>().add(OnInitializeTotalClickEvent());

            _saveClicks();
          }
        },
        child: BlocListener<RegisterFormBloc, RegisterFormState>(
          listener: (context, state) {
            if (state is RegisterFormSuccessState) {
              // Save in database
              context.read<TotalClickBloc>().add(OnInitializeTotalClickEvent());

              _saveClicks();
            }
          },
          child: BlocListener<ClickBloc, ClickState>(
            listener: (context, state) {
              if (state is ClickLoadedState) {
                setState(() => _increment = 0);
              }
            },
            child: Scaffold(
              body: InkWell(
                splashColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                onTap: _isPlaying
                    ? () => _onClick(!widget.userModel.isEmpty)
                    : null,
                child: SafeArea(
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_isPlaying && _increment > 0)
                              Text(
                                "$_increment",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: kDefaultFontSize * 5,
                                    ),
                              ),
                            if (_countdownStarted && _increment == 0)
                              AnimatedOpacity(
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                opacity: _countdownStarted ? 1 : 0,
                                child: Text(
                                  _countdown == 0
                                      ? "Cliquer"
                                      : _countdown.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        fontSize: kDefaultFontSize * 5,
                                      ),
                                ),
                              ),
                            if (!_countdownStarted && !_isPlaying)
                              IconButton(
                                onPressed: () => _startCountdown(),
                                icon: const Icon(
                                  Icons.play_circle_outline_rounded,
                                ),
                                iconSize: 120.0,
                              )
                          ],
                        ),
                      ),
                      if (!widget.userModel.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: TotalClickComponent(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
