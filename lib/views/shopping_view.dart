import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yugi_oh_cards/bloc/shopping_cart/bloc/shopping_cart_bloc.dart';

import '../bloc/log_in/bloc/log_in_bloc.dart';
import '../bloc/shopping_cart/bloc/shopping_cart_state.dart';

class ShoppingView extends StatelessWidget {
  const ShoppingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      buildWhen: (previous, current) => previous!=current,
      builder: (context, state) {
        
        if (state.shoppingState == ShoppingState.init) {
          return Text("init");
        } else if (state.shoppingState == ShoppingState.loading) {
          return const Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 50.0,
            ),
          );
        } else if (state.shoppingState == ShoppingState.loaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height * 0.67,
                child: ListView.builder(
                  itemCount: state.cardsDetails.list.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: size.width * 0.4 * 1.4,
                            width: size.width * 0.4,
                            child: Image.network(
                              state.cardsDetails.list[index].image_url,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        context.read<ShoppingCartBloc>().add(
                                            ShoppingCartChangeItem(
                                                isAdd: true,
                                                orderList: state.orderList,
                                                itemId: state
                                                    .cardsDetails.list[index].id,
                                                uid: context
                                                    .read<LogInBloc>()
                                                    .state
                                                    .message!,cardsDetails: state.cardsDetails));
                                                    
                                      },
                                      icon: const Icon(Icons.add)),
                                  Text(state.orderList[state
                                          .cardsDetails.list[index].id
                                          .toString()]
                                      .toString()),
                                  IconButton(
                                      onPressed: () {
                                        context.read<ShoppingCartBloc>().add(
                                            ShoppingCartChangeItem(
                                                isAdd: false,
                                                orderList: state.orderList,
                                                itemId: state
                                                    .cardsDetails.list[index].id,
                                                uid: context
                                                    .read<LogInBloc>()
                                                    .state
                                                    .message!,cardsDetails: state.cardsDetails));
                                      },
                                      icon: const Icon(Icons.remove)),
                                ],
                              ),
                              SizedBox(width:size.width*0.3, child: Text(state.cardsDetails.list[index].name)),
                              Row(
                                children: [
                                  const Icon(Icons.currency_yuan_rounded),
                                  Text(state.cardsDetails.list[index].card_prices),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
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
                  width: size.width * 0.2,
                  child: const Center(
                      child: Text(
                    "Buy",
                    style: TextStyle(fontSize: 23),
                  )),
                ),
              ),
            ],
          );
          
        } else {
          // cac state con lai
          return const Text("done");
        }
      },
    );
  }
}
