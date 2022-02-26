import 'package:com_nico_develop_click_combat/components/authentication/username_form/username_form_component.dart';
import 'package:com_nico_develop_click_combat/layouts/authentication_layout.dart';
import 'package:flutter/material.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({Key? key}) : super(key: key);

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthenticationLayout(
        heading: Text(
          "Commençons par choisir un pseudo de guerrier",
          style: Theme.of(context).textTheme.headline1,
        ),
        form: const UsernameFormComponent(),
      ),
    );
  }
}
