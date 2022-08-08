import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugi_oh_cards/bloc/shopping_cart/bloc/shopping_cart_bloc.dart';

import 'package:yugi_oh_cards/models/card_model.dart';
import 'package:yugi_oh_cards/models/user_model.dart';

import '../bloc/favorites/bloc/favorites_bloc.dart';
import '../bloc/log_in/bloc/log_in_bloc.dart';


 // sua lai Inherited Widget
class CardDisplay extends StatelessWidget {
  final YugiOhCard card;
  final MyUser myUser;
  const CardDisplay({
    Key? key,
    required this.card,
    required this.myUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        OpenContainer(
          closedBuilder: (context, action) => (SizedBox(
            width: size.width * 0.7,
            height: size.width * 0.7 * 1.4,
            child: Image.network(
              card.image_url,
              fit: BoxFit.fill,
            ),
          )),
          openBuilder: (BuildContext context,
              void Function({Object? returnValue}) action) {
            return Scaffold(
              appBar: AppBar(title: Text(card.name)),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      width: size.width * 0.7,
                      height: size.width * 0.7 * 1.4,
                      child: Image.network(
                        card.image_url,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)),
                          child: Text("Description: ${card.desc}")),
                    ),
                    SizedBox(
                      child: Text("Price: ${card.card_prices}"),
                    ),
                  ]),
                ),
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                  onPressed: () {
                    if (myUser.orderList[card.id.toString()] == null) {
                      myUser.orderList[card.id.toString()] = 1;
                    } else {
                      myUser.orderList[card.id.toString()] += 1;
                    }
                    context.read<LogInBloc>().add(LogInChangeInfo(
                        field: "orderList", data: myUser.orderList));
                    context
                        .read<ShoppingCartBloc>()
                        .add(ShoppingCartLoad(myUser.orderList));
                  },
                  child: const Icon(Icons.shopping_basket)),
            ),
            FavoriteChange(
              id: card.id,
              myUser: myUser,
            ),
          ],
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class FavoriteChange extends StatefulWidget {
  MyUser myUser;
  final int id;
  FavoriteChange({
    Key? key,
    required this.myUser,
    required this.id,
  }) : super(key: key);

  @override
  State<FavoriteChange> createState() => _FavoriteChangeState();
}

class _FavoriteChangeState extends State<FavoriteChange> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Colors.blue),
        onPressed: () {
          setState(() {
            if (widget.myUser.favorites.contains(widget.id)) {
              widget.myUser.favorites.remove(widget.id);
              context.read<LogInBloc>().add(LogInChangeInfo(
                  field: "favorites", data: widget.myUser.favorites));
              context
                  .read<FavoritesBloc>()
                  .add(FavoritesLoad(ids: widget.myUser.favorites));
            } else {
              widget.myUser.favorites.add(widget.id);
              context.read<LogInBloc>().add(LogInChangeInfo(
                  field: "favorites", data: widget.myUser.favorites));
              context
                  .read<FavoritesBloc>()
                  .add(FavoritesLoad(ids: widget.myUser.favorites));
            }
          });
        },
        child: !widget.myUser.favorites.contains(widget.id)
            ? const Icon(
                Icons.favorite_outline,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite,
                color: Colors.red,
              ));
  }
}
