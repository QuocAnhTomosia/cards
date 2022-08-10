import 'package:flutter/material.dart';
import 'package:yugi_oh_cards/components/constant.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/log_in', (Route<dynamic> route) => false);
        },
        icon: const Icon(Icons.skip_next),
      ),
      appBar: AppBar(
        title: const Text('Start App'),
        flexibleSpace: Constant().decoration,
      ),
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: const <Widget>[
          Center(
            child: Text('First Page', style: TextStyle(fontFamily: 'Roboto')),
          ),
          Center(
            child: Text('Second Page', style: TextStyle(fontFamily: 'Roboto')),
          ),
          Center(
            child: Text('Third Page', style: TextStyle(fontFamily: 'Roboto')),
          )
        ],
      ),
    );
  }
}
