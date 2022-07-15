import 'package:flutter/material.dart';
import 'package:yugi_oh_cards/commons/card_display.dart';
import 'package:yugi_oh_cards/models/card_model.dart';
import 'package:yugi_oh_cards/services/cards_api_services.dart';
import 'package:yugi_oh_cards/views/favourite_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const SearchWidget(),
    const FavoriteWidget(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
          ]),
      appBar: AppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),

          ),
        ),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textAlign: TextAlign.center,
            enableInteractiveSelection: false,
            obscureText: false,
            decoration: const InputDecoration(
              hintText: 'Enter your card name',
              border: UnderlineInputBorder(),
            ),
          ),
        ),
        FutureBuilder(
            future: CardApi().fetchData(name: "Mirror Force"),
            builder: (context, AsyncSnapshot<List<YugiOhCard>> snapshot) {
              if (snapshot.hasError) {
                return const Text("not match the card you found");
              } else if (!snapshot.hasData) {
                return const Text("not match the card you found");
              } else {
                return SizedBox(
                  height: size.height * 0.7,
                  width: size.width,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int index) => Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CardDisplay(card: snapshot.data![index]),
                          )),
                );
              }
            }),
      ],
    );
  }
}
