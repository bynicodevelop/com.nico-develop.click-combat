import 'package:com_nico_develop_click_combat/components/authentication/login_form/login_form_component.dart';
import 'package:com_nico_develop_click_combat/configs/constants.dart';
import 'package:com_nico_develop_click_combat/layouts/authentication_layout.dart';
import 'package:com_nico_develop_click_combat/screens/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AuthenticationLayout(
        heading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: kDefaultPadding / 2,
              ),
              child: Text(
                "Connexion",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Ou",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.grey[800],
                    ),
                children: [
                  TextSpan(
                    text: " créer un compte",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: kDefautColor,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          ),
                    // ,
                  ),
                ],
              ),
            )
          ],
        ),
        form: const LoginFormComponent(),
      ),
    );
  }
}
