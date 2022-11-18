import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splooking3/data/user.dart' as data;

Future<data.User> userData(String uid) async {
  final data.User result = data.User(
    name: '',
    avatar: '',
    friendCode: '',
    description: '',
    weapons: [],
    rank: -1,
    udemae: '',
    id: '',
    xp: -1
  );
  try {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((value) {
      result..name = value.data()!['name']
      ..avatar = value.data()!['avatar']
      ..description = value.data()!['name']
      ..udemae = value.data()!['udemae']
      ..weapons = value.data()!['weapons']
      ..friendCode = value.data()!['friendCode']
      ..rank = value.data()!['rank']
      ..id = value.data()!['id']
      ..xp = value.data()!['xp'];

      return result;
    });
  } catch (e) {
    return result;
  }
}
