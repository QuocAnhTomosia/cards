class YugiOhCard {
  int id;
  String name;
  String type;
  String desc;
  String race;
  // ignore: non_constant_identifier_names
  String image_url;
  String attribute;
  // ignore: non_constant_identifier_names
  String card_prices;
  YugiOhCard({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.race,
    // ignore: non_constant_identifier_names
    required this.image_url,
    required this.attribute,
    // ignore: non_constant_identifier_names
    required this.card_prices,
  });

  factory YugiOhCard.fromJson(Map<String, dynamic> json) {
    return YugiOhCard(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        desc: json["desc"],
        race: json["race"],
        image_url: json["card_images"][0]["image_url"],
        attribute: json["attribute"] ?? "No Atrribute",
        card_prices: json["card_prices"][0]["cardmarket_price"],);
  }
}
