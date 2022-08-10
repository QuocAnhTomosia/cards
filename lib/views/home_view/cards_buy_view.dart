import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:yugi_oh_cards/components/card_display.dart';
import 'package:yugi_oh_cards/components/fade_widget.dart';
import '../../bloc/home_bloc/bloc/home_bloc.dart';
import '../../bloc/home_bloc/bloc/home_state.dart';
import '../../bloc/log_in/bloc/log_in_bloc.dart';
import '../../bloc/log_in/bloc/log_in_state.dart';

class CardsBuyViews extends StatelessWidget {
  const CardsBuyViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(buildWhen: (previous, current) {
      return previous != current;
    }, builder: ((context, state) {
      switch (state.statusCode) {
        case StatusCode.error:
          {
            return Center(child: Text(state.data!.error));
          }
        case StatusCode.loaded:
          {
            return BlocBuilder<LogInBloc, LogInState>(
                builder: (context, logInState) {
              return ListView.builder(
                  itemCount: state.data!.list.length,
                  itemBuilder: ((context, index) {
                    return FadeWidget(
                        childWidget: CardDisplay(
                            card: state.data!.list[index],
                            myUser: logInState.myUser!));
                  }));
            });
          }
        default:
          {
            return const Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          }
      }
    }));
  }
}
