import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/data/user.dart' as data;

final currentUserAuthProvider = StreamProvider.autoDispose((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentUserProvider = StateProvider<data.User>(
  (ref) => data.User(
    name: '', 
    id: '', 
    avatar: '', 
    friendCode: '', 
    description: '', 
    weapons: [], 
    rank: -1, 
    udemae: '', 
    xp: -1
  )
);