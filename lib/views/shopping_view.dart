import 'package:flutter/material.dart';
import 'package:yugi_oh_cards/commons/buy_card_display.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';

class ShoppingView extends StatelessWidget {
  const ShoppingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: size.height * 0.7,
          child: FutureBuilder<DataResponse>(
            future: CardApi().fetchData("Dark Magician", "en"),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("snapshots has some error");
              } else if (!snapshot.hasData) {
                return const Text('snapshots dont have data');
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BuyCard(card: snapshot.data!.list[index]);
                    });
              } else {
                return const Text("data");
              }
            },
          ),
        ),
        InkWell(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xff1f005c),
                  Color(0xff5b0060),
                  Color(0xff870160),
                  Color(0xffac255e),
                  Color(0xffca485c),
                  Color(0xffe16b5c),
                  Color(0xfff39060),
                  Color(0xffffb56b),
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                tileMode: TileMode.mirror,
              ),
            ),
            height: size.height * 0.08,
            width: size.width*0.2,
            child: Center(child: Text("Buy",style: TextStyle(fontSize: 23),)),
          ),
        ),
      ],
    );
  }
}
