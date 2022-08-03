import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yugi_oh_cards/bloc/cards_searching/cards_searching_bloc.dart';

import '../bloc/log_in/bloc/log_in_bloc.dart';
import '../bloc/log_in/bloc/log_in_state.dart';
import '../commons/card_display.dart';
import '../services/cards_api_services.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<LogInBloc, LogInState>(
      builder: (context, logInState) {
        if (logInState.status != LogInStatus.success) {
          return const Icon(
            Icons.error,
            size: 150,
          );
        } else {
           context.read<CardsSearchingBloc>().add(CardSearchingIdSubmit(
                logInState.myUser!.favorites, tr("lang")));
          return BlocBuilder<CardsSearchingBloc, CardsSearchingState>(
              builder: (context, cardState) {         
            if (cardState is CardSearchingLoading) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );
            }
            if (cardState is CardSearchingError) {
              return Column(
                children: [
                  Text(cardState.respone),
                ],
              );
            }
            if (cardState is CardSearchingLoaded) {
              return ListView.builder(
                  itemCount: cardState.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        OpenContainer(
                          closedBuilder: (context, action) => (SizedBox(
                            width: size.width * 0.7,
                            height: size.width * 0.7 * 1.4,
                            child: Image.network(
                              cardState.data[index].image_url,
                              fit: BoxFit.fill,
                            ),
                          )),
                          openBuilder: (BuildContext context,
                              void Function({Object? returnValue}) action) {
                            return Scaffold(
                              appBar: AppBar(
                                  title: Text(cardState.data[index].name)),
                              body: Center(
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    SizedBox(
                                      width: size.width * 0.7,
                                      height: size.width * 0.7 * 1.4,
                                      child: Image.network(
                                        cardState.data[index].image_url,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blueAccent)),
                                          child: Text(
                                              "Description: ${cardState.data[index].desc}")),
                                    ),
                                    SizedBox(
                                      child: Text(
                                          "Price: ${cardState.data[index].card_prices}"),
                                    ),
                                  ]),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );

            } else {
              return Text("Hello");
            }
          });
        }
      },
    );
  }
}
