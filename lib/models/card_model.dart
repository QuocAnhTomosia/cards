class YugiOhCard {
  int id;
  String name;
  String type;
  String desc;
  String race;
  // ignore: non_constant_identifier_names
  String imageUrl;
  String attribute;
  // ignore: non_constant_identifier_names
  String cardPrices;
  YugiOhCard({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.race,
    // ignore: non_constant_identifier_names
    required this.imageUrl,
    required this.attribute,
    // ignore: non_constant_identifier_names
    required this.cardPrices,
  });

  factory YugiOhCard.fromJsonApi(Map<String, dynamic> json) {
    return YugiOhCard(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      desc: json["desc"],
      race: json["race"],
      imageUrl: json["card_images"][0]["image_url"],
      attribute: json["attribute"] ?? "No Atrribute",
      cardPrices: json["card_prices"][0]["cardmarket_price"],
    );
  }

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "desc": desc,
      "race": race,
      "image_url": imageUrl,
      "attribute": attribute,
      "card_prices": cardPrices
    };
  }
}
