import 'package:com_nico_develop_click_combat/components/authentication/register_form/bloc/register_form_bloc.dart';
import 'package:com_nico_develop_click_combat/components/forms/buttons/submit_button.dart';
import 'package:com_nico_develop_click_combat/components/forms/inputs/email_input.dart';
import 'package:com_nico_develop_click_combat/components/forms/inputs/password_input.dart';
import 'package:com_nico_develop_click_combat/components/forms/inputs/text_input.dart';
import 'package:com_nico_develop_click_combat/configs/constants.dart';
import 'package:com_nico_develop_click_combat/screens/home_screen.dart';
import 'package:com_nico_develop_click_combat/screens/username_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RegisterFormComponent extends StatefulWidget {
  const RegisterFormComponent({Key? key}) : super(key: key);

  @override
  State<RegisterFormComponent> createState() => _RegisterFormComponentState();
}

class _RegisterFormComponentState extends State<RegisterFormComponent> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _displayNameController.text = "jeff";
      _emailController.text = "jeff@domain.tld";
      _passwordController.text = "123456";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterFormBloc, RegisterFormState>(
      listener: (context, state) {
        if (state is RegisterFormLoadingState) {
          return;
        }

        if (state is RegisterFormSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const UsernameScreen(),
            ),
            (route) => false,
          );
        }

        if (state is RegisterFormFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Vous ne pouvez vous enregistrer avec ces identifiants.",
              ),
              backgroundColor: kDangerColor,
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            EmailInput(
              controller: _emailController,
            ),
            PasswordInput(
              controller: _passwordController,
            ),
            SubmitButton(
              label: "Créer un compte".toUpperCase(),
              onPressed: (state is RegisterFormLoadingState)
                  ? null
                  : () {
                      if (_emailController.text.isEmpty &&
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Veuillez remplir tous les champs"),
                          ),
                        );

                        return null;
                      }

                      context.read<RegisterFormBloc>().add(
                            OnRegisterFormEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    },
            ),
          ],
        );
      },
    );
  }
}
