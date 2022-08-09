import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yugi_oh_cards/bloc/shopping_cart/bloc/shopping_cart_bloc.dart';
import 'package:yugi_oh_cards/components/download_image.dart';

import 'package:yugi_oh_cards/models/card_model.dart';
import 'package:yugi_oh_cards/models/user_model.dart';

import '../bloc/favorites/bloc/favorites_bloc.dart';
import '../bloc/log_in/bloc/log_in_bloc.dart';
import 'card_open_builder.dart';
import 'favorite_button.dart';

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
    return Container(
      child: Column(
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
              return CardOpenBuilder(card: card);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                    onPressed: () {
                      //add item va update cho bloc
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
      ),
    );
  }
}

// ignore: must_be_immutable
