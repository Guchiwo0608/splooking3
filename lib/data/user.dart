class User {
  User({
    required this.name,
    required this.id,
    required this.avatar,
    required this.friendCode,
    required this.description,
    required this.weapons,
    required this.rank,
    required this.udemae,
    required this.xp 
  });
  String name;
  String id; 
  String avatar;
  String friendCode;
  String description;
  List<String> weapons;
  int rank;
  String udemae;
  int xp;
} 