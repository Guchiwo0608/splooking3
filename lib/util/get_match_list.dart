import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splooking3/data/match.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> getMatchList() {
  final matchCollectionStream = FirebaseFirestore.instance
      .collection('match')
      .where('startTime', isGreaterThanOrEqualTo: Timestamp.now())
      .snapshots();
  return matchCollectionStream;
}

List<Match> toMatchList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> matchListDocs) {
  final List<Match> matchList = [];
  for (final snapshot in matchListDocs) {
    final data = snapshot.data();
    final id = snapshot.id;
    final match = getMatchFromFirestore(data, id);
    matchList.add(match);
  }

  matchList.sort((a, b) => a.startTime.compareTo(b.startTime));
  return matchList;
}

Match getMatchFromFirestore(Map<String, dynamic> snapshot, String id) {
  final start = snapshot['startTime'] as Timestamp;
  if (snapshot['matchType'] != null) {
    final start = snapshot['startTime'] as Timestamp;
    final publicMatch = PublicMatch(
      id: id,
      name: snapshot['name'],
      hostId: snapshot['hostId'],
      matchType: snapshot['matchType'],
      startTime: start.toDate().toLocal(),
      numberOfPeople: snapshot['numberOfPeople'],
      comment: snapshot['comment'],
      member: List.from(snapshot['member']),
      rule: snapshot['rule'],
      stage: List.from(snapshot['stage']),
      options: List.from(snapshot['options']),
    );
    return publicMatch;
  } else if (snapshot['weapons'] != null) {
    final salmonRunMatch = SalmonrunMatch(
      id: id,
      name: snapshot['name'],
      hostId: snapshot['hostId'],
      startTime: start.toDate().toLocal(),
      numberOfPeople: snapshot['numberOfPeople'],
      member: List.from(snapshot['member']),
      comment: snapshot['comment'],
      weapons: List.from(snapshot['weapons']),
      stage: snapshot['stage'],
      options: List.from(snapshot['options']),
    );
    return salmonRunMatch;
  } else {
    final PrivateMatch privateMatch = PrivateMatch(
      id: id,
      name: snapshot['name'],
      hostId: snapshot['hostId'],
      startTime: start.toDate().toLocal(),
      numberOfPeople: snapshot['numberOfPeople'],
      comment: snapshot['comment'],
      member: List.from(snapshot['member']),
      rule: List.from(snapshot['rule']),
      options: List.from(snapshot['options']),
      stage: List.from(snapshot['stage']),
    );
    return privateMatch;
  }
}
