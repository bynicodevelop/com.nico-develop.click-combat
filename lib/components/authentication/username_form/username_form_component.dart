import 'package:com_nico_develop_click_combat/components/authentication/username_form/bloc/username_bloc.dart';
import 'package:com_nico_develop_click_combat/components/forms/buttons/submit_button.dart';
import 'package:com_nico_develop_click_combat/components/forms/inputs/text_input.dart';
import 'package:com_nico_develop_click_combat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:com_nico_develop_click_combat/components/profile_avatar/profile_avatar_component.dart';
import 'package:com_nico_develop_click_combat/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UsernameFormComponent extends StatefulWidget {
  const UsernameFormComponent({Key? key}) : super(key: key);

  @override
  State<UsernameFormComponent> createState() => _UsernameFormComponentState();
}

class _UsernameFormComponentState extends State<UsernameFormComponent> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      if (_usernameController.text.isEmpty) return;

      context.read<ProfileAvatarBloc>().add(
            OnUpdateProfileAvatar(
              avatar: _usernameController.text,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsernameBloc, UsernameState>(
      listener: (context, state) {
        if (state is UsernameAlreadyExistsState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "Ce nom de guerrier existe déjà... Vous ne voudriez pas vous trouver dans l'ombre d'un autre guerrier."),
            ),
          );

          return;
        }

        if (state is UsernameLoadedState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: Column(
        children: [
          const ProfileAvatarComponent(
            paddingDelta: 20,
          ),
          TextInput(
            controller: _usernameController,
            required: true,
          ),
          SubmitButton(
            onPressed: () {
              if (_usernameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Veuillez remplir tous les champs"),
                  ),
                );

                return null;
              }

              context.read<UsernameBloc>().add(
                    OnSetUsernameEvent(
                      displayName: _usernameController.text,
                    ),
                  );
            },
            label: "C'est parti !",
          ),
        ],
      ),
    );
  }
}
