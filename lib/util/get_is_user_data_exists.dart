import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> getIsUserDataExists({required String uid}) async {

  final isUserDataExists = FirebaseFirestore.instance
      .collection('user')
      .doc(uid)
      .get()
      .then((value) {
        return value.exists;
      });
  
  return isUserDataExists;
}

