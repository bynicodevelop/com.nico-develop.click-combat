import 'package:com_nico_develop_click_combat/services/ranking/ranking_bloc.dart';
import 'package:flutter/material.dart';
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
        child: Column(
          children: <Widget>[
            BlocBuilder<RankingBloc, RankingState>(
              bloc: context.read<RankingBloc>()
                ..add(
                  OnInitializeRankingEvent(),
                ),
              builder: (context, state) {
                List<Map<String, dynamic>> rankings =
                    (state as RankingInitialState).rankings;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: rankings.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${rankings[index]['displayName']}'.substring(0, 4),
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
                        leading: CircleAvatar(
                          child: Text('$index'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const Card(
              child: ListTile(
                title: Text('Vous êtes le ici'),
                subtitle: Text("Votre position est 40 123"),
                trailing: Text('Score: 1,2K'),
                leading: CircleAvatar(
                  child: Text('40K'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
