class Match {
  Match({
    required this.id,
    required this.name,
    required this.hostId,
    required this.startTime,
    required this.numberOfPeople,
    required this.member,
    required this.comment,
    required this.options
  });
  String id;
  String name;
  String hostId;
  DateTime startTime;
  int numberOfPeople;
  List<String> member;
  String comment;
  List<String> options;
}

class PublicMatch extends Match {
  PublicMatch({
    required String id,
    required String name,
    required String hostId,
    required DateTime startTime,
    required int numberOfPeople,
    required List<String> member,
    required String comment,
    required List<String> options,
    required this.matchType,
    required this.rule,
    required this.stage
  }) : super(
    id: id,
    name: name,
    hostId: hostId,
    startTime: startTime,
    numberOfPeople: numberOfPeople,
    member: member,
    comment: comment,
    options: options,
  );
  String matchType;
  String rule;
  List<String> stage;
}

class PrivateMatch extends Match {
  PrivateMatch({
    required String id,
    required String name,
    required String hostId,
    required DateTime startTime,
    required int numberOfPeople,
    required List<String> member,
    required String comment,
    required List<String> options,
    required this.rule,
    required this.stage,
  }) : super(
    id: id,
    name: name,
    hostId: hostId,
    startTime: startTime,
    numberOfPeople: numberOfPeople,
    member: member,
    comment: comment,
    options: options,
  );
  List<String> rule;
  List<String> stage;
}

class SalmonrunMatch extends Match {
  SalmonrunMatch({
    required String id,
    required String name,
    required String hostId,
    required DateTime startTime,
    required int numberOfPeople,
    required List<String> member,
    required String comment,
    required List<String> options,
    required this.stage,
    required this.weapons
  }) : super(
    id: id,
    name: name,
    hostId: hostId,
    startTime: startTime,
    numberOfPeople: numberOfPeople,
    member: member,
    comment: comment,
    options: options,
  );
  String stage;
  List<String> weapons;
}