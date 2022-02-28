import 'package:com_nico_develop_click_combat/components/authentication/logout_button/bloc/logout_bloc.dart';
import 'package:com_nico_develop_click_combat/components/authentication/username_form/bloc/username_bloc.dart';
import 'package:com_nico_develop_click_combat/components/forms/inputs/text_input.dart';
import 'package:com_nico_develop_click_combat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:com_nico_develop_click_combat/components/profile_avatar/profile_avatar_component.dart';
import 'package:com_nico_develop_click_combat/models/profile_model.dart';
import 'package:com_nico_develop_click_combat/services/profile/profile_bloc.dart';
import 'package:com_nico_develop_click_combat/widgets/buttons/main_button.dart';
import 'package:com_nico_develop_click_combat/widgets/svg_avatar.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
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
                    const ProfileAvatarComponent(),
                    Positioned(
                      right: 20.0,
                      child: IconButton(
                        onPressed: () => context.read<LogoutBloc>().add(
                              OnLogoutEvent(),
                            ),
                        icon: const Icon(
                          Icons.logout,
                        ),
                      ),
                    ),
                    // SvgAvatar(
                    //   id: profileModel.displayName,
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
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
                      SizedBox(
                        width: double.infinity,
                        height: 45.0,
                        child: MainButton(
                          label: "Modifier",
                          onPressed: () {
                            if (_editingMode) {
                              // save
                              context.read<UsernameBloc>().add(
                                    OnSetUsernameEvent(
                                      displayName: _usernameController.text,
                                    ),
                                  );
                            }

                            setState(() => _editingMode = !_editingMode);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
