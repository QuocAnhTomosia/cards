import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yugi_oh_cards/providers/lang_provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        OpenContainer(
            closedBuilder: (context, action) => SizedBox(
                  height: size.height * 0.1,
                  width: size.width,
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Language",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
            openBuilder: (context, action) => Scaffold(
                  appBar: AppBar(
                    title: const Text("Language"),
                  ),
                  body: Consumer<LanguageProvider>(
                    builder: (context, value, child) => Column(
                      children: [
                        InkWell(
                          onTap: value.changeLanguage("vi"),
                          child: SizedBox(height: size.height*0.08,
                              child: Row(
                            children: [Text("Tieng Viet"),Visibility(visible: value.current == "vi", child: Icon(Icons.check))],
                          )),
                        ),
                        InkWell(
                          onTap: value.changeLanguage("en"),
                          child: SizedBox(height: size.height*0.08,
                              child: Row(
                            children: [Text("English"),Visibility(visible: value.current == "en", child: Icon(Icons.check))],
                          )),
                        )
                      ],
                    ),
                  ),
                )),
      ],
    );
  }
}
