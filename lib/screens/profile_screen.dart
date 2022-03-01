import 'package:com_nico_develop_click_combat/components/authentication/logout_button/bloc/logout_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/username_form/bloc/username_bloc.dart';
import 'package:com_nico_develop_click_combat/components/forms/inputs/text_input.dart';
import 'package:com_nico_develop_click_combat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:com_nico_develop_click_combat/components/profile_avatar/profile_avatar_component.dart';
import 'package:com_nico_develop_click_combat/models/profile_model.dart';
import 'package:com_nico_develop_click_combat/screens/home_screen.dart';
import 'package:com_nico_develop_click_combat/services/profile/profile_bloc.dart';
import 'package:com_nico_develop_click_combat/widgets/buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _editingMode = false;

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
          setState(() => _editingMode = !_editingMode);
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is! ProfileLoadedState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          ProfileModel profileModel = state.profileModel;
          _usernameController.text = profileModel.displayName;

          context.read<ProfileAvatarBloc>().add(
                OnUpdateProfileAvatar(
                  avatar: profileModel.displayName,
                ),
              );

          return Scaffold(
            body: SafeArea(
              child: ListView(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: ProfileAvatarComponent(),
                      ),
                      Positioned(
                        right: 15.0,
                        child: BlocListener<LogoutBloc, LogoutState>(
                          listener: (context, state) {
                            if (state is LogoutSuccessState) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                  (route) => false);
                            }
                          },
                          child: IconButton(
                            onPressed: () => context.read<LogoutBloc>().add(
                                  OnLogoutEvent(),
                                ),
                            icon: const Icon(
                              Icons.logout,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15.0,
                        child: BlocListener<LogoutBloc, LogoutState>(
                          listener: (context, state) {
                            if (state is LogoutSuccessState) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          child: TextButton(
                            onPressed: () {
                              if (_editingMode) {
                                // save
                                context.read<UsernameBloc>().add(
                                      OnSetUsernameEvent(
                                        displayName: _usernameController.text,
                                      ),
                                    );
                              } else {
                                setState(() => _editingMode = !_editingMode);
                              }
                            },
                            child: Text(
                              !_editingMode
                                  ? "Modifier".toUpperCase()
                                  : "Enregistrer".toUpperCase(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        if (!_editingMode)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18.0,
                            ),
                            child: Text(
                              _usernameController.text,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        if (_editingMode)
                          TextInput(
                            controller: _usernameController,
                            label: "Votre nom d'utilisateur",
                            errorText: "Merci de saisir un nom d'utilisateur",
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 6.0,
                            ),
                            child: Text(
                              "${profileModel.clicks}",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Text(
                            "Clicks".toUpperCase(),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 6.0,
                            ),
                            child: Text(
                              "${profileModel.victories}",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Text(
                            "Victoires".toUpperCase(),
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
