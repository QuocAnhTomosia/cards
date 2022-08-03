import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yugi_oh_cards/bloc/cards_searching/cards_searching_bloc.dart';
import 'package:yugi_oh_cards/commons/card_display.dart';
import 'package:yugi_oh_cards/commons/fade_widget.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';

import '../bloc/log_in/bloc/log_in_bloc.dart';
import '../bloc/log_in/bloc/log_in_state.dart';

class CardsBuyViews extends StatelessWidget {
  const CardsBuyViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CardsSearchingBloc>().add(const CardRandomSubit());
    return BlocBuilder<CardsSearchingBloc, CardsSearchingState>(
        builder: ((context, state) {
      if (state is CardSearchingLoading) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      }
      if (state is CardSearchingError) {
        return Text(state.respone);
      }
      if (state is CardSearchingLoaded) {
        return BlocBuilder<LogInBloc, LogInState>(
          builder: (context, logInState) {
            return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: ((context, index) {
                  return FadeWidget(
                      childWidget: CardDisplay(
                          card: state.data[index],
                          myUser: context.read<LogInBloc>().state.myUser!));
                }));
          },
        );
      } else {
        context.read<CardsSearchingBloc>().add(const CardRandomSubit());
        return Text("Hello");
      }
    }));
  }
}
