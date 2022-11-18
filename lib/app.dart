import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/auth/user_auth.dart';
import 'package:splooking3/pages/matchListPage/match_list_page.dart';
import 'package:splooking3/pages/profile_regist_page.dart';
import 'package:splooking3/pages/schedulePage/schedule_page.dart';
import 'package:splooking3/pages/sign_up_page.dart';
import 'package:splooking3/pages/userPage/user_page.dart';
import 'package:splooking3/util/get_is_user_data_exists.dart';

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAuth = ref.watch(currentUserAuthProvider);
    final isLoggedIn = currentUserAuth.value != null;
    bool isCurrentUserDataExists = isLoggedIn;

    if (isLoggedIn) {
      final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      getIsUserDataExists(uid: currentUserUid).then((value) {
        isCurrentUserDataExists = value;
      });
    }

    return ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: isLoggedIn
                ? (isCurrentUserDataExists
                    ? const ScreenContainer()
                    : const ProfileRegistPage())
                : const SignUpPage(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

enum Tabtype { matchList, makingMatch, profile }

final tabtypeProvider = StateProvider<Tabtype>((ref) => Tabtype.matchList);

class ScreenContainer extends HookConsumerWidget {
  const ScreenContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabtype = ref.watch(tabtypeProvider);

    const pages = [
      MatchListPage(),
      SchedulePage(),
      UserPage(),
    ];

    return IndexedStack(
      index: tabtype.index,
      children: pages,
    );
  }
}
