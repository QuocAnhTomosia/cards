import 'package:flutter/material.dart';
import 'package:yugi_oh_cards/components/download_image.dart';

import 'package:yugi_oh_cards/models/card_model.dart';

// ignore: must_be_immutable
class CardOpenBuilder extends StatelessWidget {
  YugiOhCard card;
CardOpenBuilder({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
                appBar: AppBar(title: Text(card.name)),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      InkWell(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => MyDiaLog(
                                imgLink: card.imageUrl,
                                parentContext: context),
                          );
                        },
                        child: SizedBox(
                          width: size.width * 0.7,
                          height: size.width * 0.7 * 1.4,
                          child: Image.network(
                            card.imageUrl,
                            fit: BoxFit.fill,
                          ),
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
                        child: Text("Price: ${card.cardPrices}"),
                      ),
                    ]),
                  ),
                ),
              );
  }
}
