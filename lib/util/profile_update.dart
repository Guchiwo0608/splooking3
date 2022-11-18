import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splooking3/data/user.dart' as data;

Future<String> profileUpdate({required data.User user}) async {
  final currentUserAuthUid = FirebaseAuth.instance.currentUser!.uid;
  final currentUserFirestore =
      FirebaseFirestore.instance.collection('user').doc(currentUserAuthUid);

  try {
    currentUserFirestore.get().then((value) async {
      if (value.exists) {
        await currentUserFirestore.update({
          'name': user.name,
          'avatar': user.avatar,
          'friendCode': user.friendCode,
          'description': user.description,
          'weapons': user.weapons,
          'rank': user.rank,
          'udemae': user.udemae,
          'xp': user.xp,
        });
      } else {
        await currentUserFirestore.set({
          'name': user.name,
          'avata': user.avatar,
          'friendCode': user.friendCode,
          'description': user.description,
          'weapons': user.weapons,
          'rank': user.rank,
          'udemae': user.udemae,
          'xp': user.xp,
        });
      }
    });
    return '';
  } catch (e) {
    return '予期せぬエラーが発生しました。';
  }
}
