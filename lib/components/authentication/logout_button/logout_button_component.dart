import 'package:com_nico_develop_click_combat/components/authentication/logout_button/bloc/logout_bloc.dart';
import 'package:com_nico_develop_click_combat/widgets/buttons/danger_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LogoutButtonComponent extends StatelessWidget {
  const LogoutButtonComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DangerButton(
      label: "Se donnecter",
      onPressed: () => context.read<LogoutBloc>().add(
            OnLogoutEvent(),
          ),
    );
  }
}
