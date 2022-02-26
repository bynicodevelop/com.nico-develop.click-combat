import 'package:com_nico_develop_click_combat/components/authentication/logout_button/bloc/logout_bloc.dart';
import 'package:com_nico_develop_click_combat/widgets/buttons/main_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MainButton(
                label: "Déconnexion",
                onPressed: () {
                  context.read<LogoutBloc>().add(
                        OnLogoutEvent(),
                      );
                }),
          ],
        ),
      ),
    );
  }
}
