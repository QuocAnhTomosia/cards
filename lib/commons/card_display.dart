import 'package:flutter/material.dart';
import 'package:yugi_oh_cards/models/card_model.dart';

class CardDisplay extends StatelessWidget {
  final YugiOhCard card;
  const CardDisplay({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        
             ClipRRect(
          child: SizedBox(
            width: size.width * 0.7,
            height: size.width* 0.7*1.4,
            child: Image.network(
              card.image_url,
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }
}
