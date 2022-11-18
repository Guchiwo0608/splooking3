import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splooking3/components/buttons.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/match_tile.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/components/widgets.dart';
import 'package:splooking3/data/match.dart' as data;
import 'package:splooking3/data/user.dart' as model;
import 'package:splooking3/util/get_match_list.dart';
import 'package:splooking3/util/get_user_data_from_firebase.dart';
import 'package:splooking3/util/show_dialog.dart';

class MatchDetailPage extends StatelessWidget {
  const MatchDetailPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final matchListSnapshot = getMatchList();
    final currentUserUid = FirebaseAuth.instance.currentUser?.uid;

    Widget getMatchTile(data.Match match) {
      Widget matchTile;
      if (match is data.PublicMatch) {
        matchTile = PublicMatchTile(match: match);
      } else if (match is data.PrivateMatch) {
        matchTile = PrivateMatchTile(match: match);
      } else {
        matchTile = SalmonRunMatchTile(match: match as data.SalmonrunMatch);
      }
      return matchTile;
    }

    Future<void> joinMatch(String user, data.Match match) async {
      try {
        FirebaseFirestore.instance.collection('match').doc(match.id).update({
          'numberOfPeople': match.numberOfPeople - 1,
          'member': match.member,
        });
      } catch (e) {
        showErrorAlertDialog(
          context: context,
          errorText: '予期せぬエラーが発生しました。',
        );
      }
    }

    Future<void> exitMatch(String user, data.Match match) async {
      try {
        FirebaseFirestore.instance.collection('match').doc(match.id).update({
          'numberOfPeople': match.numberOfPeople + 1,
          'member': match.member,
        });
      } catch (e) {
        showErrorAlertDialog(
          context: context,
          errorText: '予期せぬエラーが発生しました。',
        );
      }
    }

    Future<void> deleteMatch(data.Match match) async {
      try {
        FirebaseFirestore.instance
            .collection('match')
            .doc(match.id)
            .delete()
            .then((value) => Navigator.of(context).pop());
      } catch (e) {
        showErrorAlertDialog(
          context: context,
          errorText: '予期せぬエラーが発生しました。',
        );
      }
    }

    return StreamBuilder(
        stream: matchListSnapshot,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: backgroundColor,
                elevation: 0,
                title: Row(
                  children: [
                    SizedBox(width: 12.w),
                    BackButton(
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: 4.w),
                    SizedBox(
                      width: 300.w,
                      child: const Head3(text: 'Match Detail'),
                    ),
                  ],
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: backgroundColor,
                elevation: 0,
                title: Row(
                  children: [
                    SizedBox(width: 12.w),
                    BackButton(
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: 4.w),
                    SizedBox(
                      width: 300.w,
                      child: const Head3(text: 'Match Detail'),
                    ),
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    const Head4(
                      text: 'エラーが発生しました。',
                      color: Colors.red,
                    ),
                    OutLinedButton(
                      onTaped: () {},
                      color: Colors.grey[400]!,
                      child: const Body1(text: '再施行する。'),
                    ),
                  ],
                ),
              ),
            );
          }

          final matchList = toMatchList(snapshot.data!.docs);

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor,
              elevation: 0,
              title: Row(
                children: [
                  SizedBox(width: 12.w),
                  BackButton(
                    color: Colors.black,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 4.w),
                  SizedBox(
                    width: 200.w,
                    child: const Head3(text: 'Match Detail'),
                  ),
                  SizedBox(
                    width: 52.w,
                  ),
                  matchList[index].hostId == currentUserUid
                      ? GestureDetector(
                          child: Icon(
                            Icons.edit,
                            size: 32.w,
                            color: const Color.fromARGB(255, 93, 93, 93),
                          ),
                          onTap: () {},
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            backgroundColor: backgroundColor,
            body: Center(
              child: SizedBox(
                width: 380.w,
                height: 800.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(16.w)),
                        ),
                        width: 360.w,
                        child: Column(
                          children: [
                            Container(
                              height: 52.h,
                              width: 352.w,
                              padding: EdgeInsets.only(
                                left: 20.w,
                                top: 20.h,
                                bottom: 4.h,
                              ),
                              child: const Head4(
                                text: '・Match概要',
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(
                              width: 320.w,
                              child: getMatchTile(matchList[index]),
                            ),
                            SizedBox(height: 18.h),
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 238, 236, 236),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.w))),
                              width: 320.w,
                              padding: EdgeInsets.all(14.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 32.h,
                                    width: 300.w,
                                    padding: EdgeInsets.only(
                                      left: 12.w,
                                      top: 4.h,
                                      bottom: 8.h,
                                    ),
                                    child: const Head4(
                                      text: '・ホストからのコメント',
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    height: 120.h,
                                    width: 280.w,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                      horizontal: 8.w,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2.w, color: Colors.black87),
                                      borderRadius: BorderRadius.circular(12.w),
                                    ),
                                    child:
                                        Body1(text: matchList[index].comment),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Column(
                        children: [
                          Container(
                            height: 50.h,
                            width: 352.w,
                            padding: EdgeInsets.only(
                              left: 20.w,
                              top: 20.h,
                              bottom: 4.h,
                            ),
                            child: const Head4(
                              text: '・オプションタグ',
                              color: Colors.black87,
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: 320.w,
                              child: Wrap(
                                children: matchList[index].options.map((e) {
                                  return Container(
                                    height: 36.h,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 4.h, horizontal: 6.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6.h, horizontal: 8.w),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        border: Border.all(
                                            color: Colors.grey[500]!,
                                            width: 2.w),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.w))),
                                    child: Text(
                                      '#$e',
                                      style: TextStyle(
                                        fontSize: 14.w,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28.h),
                      matchList[index].member.contains(currentUserUid)
                          ? OutLinedButton(
                              elevation: 3,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              onTaped: () {
                                exitMatch(currentUserUid!, matchList[index]);
                              },
                              color: Colors.blueGrey[300]!,
                              child: const Body1(
                                text: '参加をやめる',
                              ),
                            )
                          : matchList[index].hostId == currentUserUid
                              ? OutLinedButton(
                                  elevation: 3,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  onTaped: () {
                                    deleteMatch(matchList[index]);
                                  },
                                  color: Colors.red[200]!,
                                  child: const Head5(
                                    text: '募集をやめる',
                                  ),
                                )
                              : OutLinedButton(
                                  elevation: 3,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 60.w),
                                  onTaped: () {
                                    joinMatch(
                                        currentUserUid!, matchList[index]);
                                  },
                                  color: Colors.lightGreen,
                                  child: const Head4(text: '参加する'),
                                ),
                      SizedBox(
                        width: 332.w,
                        height: 40.h,
                        child: const Divider(color: Colors.black38),
                      ),
                      const Center(child: Head4(text: '参加予定メンバー')),
                      SizedBox(height: 12.h),
                      Center(
                        child: GestureDetector(
                          child: Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: matchList[index].member.map((member) {
                              final user = userData(member);
                              return FutureBuilder(
                                  future: user,
                                  builder: (context,
                                      AsyncSnapshot<model.User> snapshot) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 6.h),
                                      width: 160.w,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey[700]!),
                                        borderRadius:
                                            BorderRadius.circular(12.w),
                                      ),
                                      child: AvatarAndName(
                                        text: snapshot.data != null
                                            ? snapshot.data!.name
                                            : '',
                                        size: 14.w,
                                      ),
                                    );
                                  });
                            }).toList(),
                          ),
                          onTap: () {},
                        ),
                      ),
                      SizedBox(height: 52.h),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: GestureDetector(
              child: Container(
                height: 64.w,
                width: 64.w,
                decoration: BoxDecoration(
                  color: const Color(0x88FFB159),
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(414.w),
                ),
                child: const Icon(Icons.comment),
              ),
              onTap: getMatchList,
            ),
          );
        });
  }
}
