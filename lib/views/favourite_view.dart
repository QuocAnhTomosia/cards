import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yugi_oh_cards/bloc/favorites/bloc/favorites_bloc.dart';
import 'package:yugi_oh_cards/bloc/log_in/bloc/log_in_bloc.dart';

import '../bloc/favorites/bloc/favorites_state.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
      if (state.status == FavoritesStatus.init) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      } else if (state.status == FavoritesStatus.loading) {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      } else if (state.status == FavoritesStatus.loaded) {
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
                        state.data!.list[index].image_url,
                        fit: BoxFit.fill,
                      ),
                    )),
                    openBuilder: (BuildContext context,
                        void Function({Object? returnValue}) action) {
                      return Scaffold(
                        appBar:
                            AppBar(title: Text(state.data!.list[index].name)),
                        body: Center(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Dialog"),
                                          actions: [
                                            TextButton(
                                              
                                              onPressed: () {

                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: SizedBox(
                                  width: size.width * 0.7,
                                  height: size.width * 0.7 * 1.4,
                                  child: Image.network(
                                    state.data!.list[index].image_url,
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
                                    "Price: ${state.data!.list[index].card_prices}"),
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
      } else {
        return const Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      }
    });
  }
}
