import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yugi_oh_cards/models/card_model.dart';

class CardDatabaseHelper {
  CardDatabaseHelper._privateConstructor();
  static final CardDatabaseHelper instance =
      CardDatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'card_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
CREATE TABLE cards(
      id INTEGER PRIMARY KEY,
      TEXT name,
      TEXT type,
      TEXT desc,
      TEXT race,
      TEXT image_url,
      TEXT attribute,
      TEXT card_prices);
    ''');
  }

  Future<int> addCard(YugiOhCard yugiOhCard) async {
    Database db = await instance.database;
    return await db.insert('cards', yugiOhCard.toMap());
  }

  // Future<List<YugiOhCard>> getFavoriteCards() async {
  //   Database db = await instance.database;
  //   var tmp = await db.query("favorite", orderBy: 'id');
  //   List<int> favorites = tmp.isNotEmpty ? tmp.map((e) => Favorite.fromMap())
  //   var notes = await db.query('cards', where: 'id= ?');
  // }
}
// CRUD for Database
