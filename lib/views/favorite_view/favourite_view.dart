import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yugi_oh_cards/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:yugi_oh_cards/components/download_image.dart';

import '../../bloc/favorites/bloc/favorites_state.dart';

class FavoriteWiew extends StatelessWidget {
  const FavoriteWiew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        buildWhen: (previous, current) {
      return previous != current;
    }, builder: (context, state) {
      switch (state.status) {
        case FavoritesStatus.loaded:
          {
            return ListView.builder(
                itemCount: state.data!.list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: OpenContainer(
                        closedBuilder: (context, action) => (SizedBox(
                          width: size.width * 0.7,
                          height: size.width * 0.7 * 1.4,
                          child: Image.network(
                            state.data!.list[index].imageUrl,
                            fit: BoxFit.fill,
                          ),
                        )),
                        openBuilder: (BuildContext context,
                            void Function({Object? returnValue}) action) {
                          return Scaffold(
                            appBar: AppBar(
                                title: Text(state.data!.list[index].name)),
                            body: Center(
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return MyDiaLog(
                                                imgLink: state
                                                    .data!.list[index].imageUrl,
                                                parentContext: context);
                                          });
                                    },
                                    child: SizedBox(
                                      width: size.width * 0.7,
                                      height: size.width * 0.7 * 1.4,
                                      child: Image.network(
                                        state.data!.list[index].imageUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueAccent)),
                                        child: Text(
                                            "Description: ${state.data!.list[index].desc}")),
                                  ),
                                  SizedBox(
                                    child: Text(
                                        "Price: ${state.data!.list[index].cardPrices}"),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                });
          }
        case FavoritesStatus.error:
          {
            return const Center(
              child: Icon(
                Icons.error,
                size: 100,
              ),
            );
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
    });
  }
}
