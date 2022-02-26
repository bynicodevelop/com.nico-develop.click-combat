import 'package:com_nico_develop_click_combat/components/click_combat/total_click/bloc/total_click_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalClickComponent extends StatelessWidget {
  const TotalClickComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalClickBloc, TotalClickState>(
      builder: (context, state) {
        final data = (state as TotalClickInitialState).data;

        return Text(
          data["clicks"].toString(),
          style: Theme.of(context).textTheme.headline1,
        );
      },
    );
  }
}
