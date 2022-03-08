import 'package:com_nico_develop_click_combat/components/ranking_profile_avatar.dart';
import 'package:com_nico_develop_click_combat/configs/constants.dart';
import 'package:com_nico_develop_click_combat/services/ranking/ranking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classement'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            BlocBuilder<RankingBloc, RankingState>(
              bloc: context.read<RankingBloc>()
                ..add(
                  OnInitializeRankingEvent(),
                ),
              builder: (context, state) {
                List<Map<String, dynamic>> rankings =
                    (state as RankingInitialState).rankings;

                if (rankings.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding * 3,
                      ),
                      child: Text(
                        "Vous pouvez encore\nfaire votre place !",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  height: 1.6,
                                ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: rankings.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${rankings[index]['displayName']}',
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Score',
                            ),
                            Text(
                              NumberFormat.compact().format(
                                rankings[index]['clicks'],
                              ),
                            ),
                          ],
                        ),
                        leading: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 50,
                          ),
                          child: RankingProfileAvatar(
                            username: rankings[index]['displayName'],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
