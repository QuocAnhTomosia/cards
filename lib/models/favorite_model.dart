class Favorite {
  int userId;
  List<int> _favorites = [];
  Favorite({
    required this.userId,
  });

  void add(int data) {
    _favorites.add(data);
  }

  bool remove(int data) {
    return _favorites.remove(data);
  }

  get() => _favorites;
  set(List<int> favorites) => _favorites = favorites;

  static fromMap() {}
}
