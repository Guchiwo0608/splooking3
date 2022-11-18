import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/constants.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/components/widgets.dart';
import 'package:splooking3/data/match.dart' as data;
import 'package:splooking3/util/get_user_data_from_firebase.dart';

Future<String> getUserName(String uid) async {
  final user = await userData(uid);
  if (user.name.isNotEmpty) {
    return user.name;
  } else {
    return '';
  }
}

class PublicMatchTile extends StatelessWidget {
  const PublicMatchTile({
    Key? key,
    required this.match,
  }) : super(key: key);

  final data.PublicMatch match;

  @override
  Widget build(BuildContext context) {
    final hostName = getUserName(match.hostId);
    final startTime = dateFormat.format(match.startTime);
    final matchType = match.matchType;

    return FutureBuilder(
      future: hostName,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return EmptyMatchTile(text: 'Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const EmptyMatchTile(text: 'データがありません。');
          }
          return Container(
            width: 360.w,
            height: 192.h,
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: matchType == 'バンカラマッチ(オープン)'
                  ? splatoonLightOpenMatchColor
                  : (matchType == 'リーグマッチ'
                      ? splatoonLightLeagueMatchColor
                      : splatoonLightLegularMatchColor),
              border: Border.all(
                color: Colors.black54,
                width: 2.h,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16.w)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Head5(
                      text: matchType,
                      color: const Color.fromARGB(144, 0, 0, 0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvatarAndName(
                      text: '${snapshot.data}',
                      size: 16.w,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      children: [
                        Text(
                          '残り：',
                          style: TextStyle(fontSize: 12.h),
                        ),
                        Text(
                          '${match.numberOfPeople}人',
                          style: TextStyle(
                            fontSize: 16.h,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.star_border,
                      size: 20.h,
                      color: Colors.yellow[900],
                    ),
                    SizedBox(width: 4.w),
                    Head4(text: match.name),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '開始時間：$startTime',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 14.h,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'ルール：${match.rule}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 14.h,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'ステージ：${match.stage[0]}, ${match.stage[1]}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 14.h,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class PrivateMatchTile extends StatelessWidget {
  const PrivateMatchTile({
    Key? key,
    required this.match,
  }) : super(key: key);

  final data.PrivateMatch match;

  @override
  Widget build(BuildContext context) {
    final ruleList = StringBuffer('ルール：');
    for (int i = 0; i < match.rule.length; i++) {
      ruleList.write(match.rule[i]);
      if (i != match.rule.length - 1) {
        ruleList.write(', ');
      }
    }
    final optionsList = StringBuffer('オプション：');
    for (int i = 0; i < match.options.length; i++) {
      optionsList.write(match.options[i]);
      if (i != match.options.length - 1) {
        optionsList.write(', ');
      }
    }
    final hostName = getUserName(match.hostId);
    final startTime = dateFormat.format(match.startTime);
    return FutureBuilder(
        future: hostName,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return EmptyMatchTile(text: 'Error: ${snapshot.data}');
            }
            if (!snapshot.hasData) {
              return const EmptyMatchTile(text: 'データがありません。');
            }
            return Container(
              width: 360.w,
              height: 192.h,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: splatoonLightPrivateMatchColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 2.h,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.w)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Head5(
                        text: 'プライベートマッチ',
                        color: Color.fromARGB(144, 0, 0, 0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarAndName(
                        text: '${snapshot.data}',
                        size: 16.w,
                      ),
                      Row(
                        children: [
                          Text(
                            '残り：',
                            style: TextStyle(fontSize: 12.h),
                          ),
                          Text(
                            '${match.numberOfPeople}人',
                            style: TextStyle(
                              fontSize: 16.h,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 20.h,
                        color: Colors.yellow[900],
                      ),
                      SizedBox(width: 4.w),
                      Head4(text: match.name),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '開始時間：$startTime',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14.h,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    ruleList.toString(),
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14.h,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    optionsList.toString(),
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14.h,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}

class SalmonRunMatchTile extends StatelessWidget {
  const SalmonRunMatchTile({
    Key? key,
    required this.match,
  }) : super(key: key);

  final data.SalmonrunMatch match;

  @override
  Widget build(BuildContext context) {
    final weaponsList = StringBuffer('ブキ：');
    for (int i = 0; i < match.weapons.length; i++) {
      weaponsList.write(match.weapons[i]);
      if (i != match.weapons.length - 1) {
        weaponsList.write(', ');
      }
    }
    final hostName = getUserName(match.hostId);
    final startTime = dateFormat.format(match.startTime);
    return FutureBuilder(
        future: hostName,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return EmptyMatchTile(text: 'Error: ${snapshot.data}');
            }
            if (!snapshot.hasData) {
              return const EmptyMatchTile(text: 'データがありません。');
            }
            return Container(
              width: 360.w,
              height: 192.h,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: splatoonLightSalmonRunMatchColor,
                border: Border.all(
                  color: Colors.black54,
                  width: 2.h,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.w)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Head5(
                        text: 'サーモンラン',
                        color: Color.fromARGB(144, 0, 0, 0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AvatarAndName(
                        text: '${snapshot.data}',
                        size: 16.w,
                      ),
                      Row(
                        children: [
                          Text(
                            '残り：',
                            style: TextStyle(fontSize: 12.h),
                          ),
                          Text(
                            '${match.numberOfPeople}人',
                            style: TextStyle(
                              fontSize: 16.h,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 20.h,
                        color: Colors.yellow[900],
                      ),
                      SizedBox(width: 4.w),
                      Head4(text: match.name),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '開始時間：$startTime',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14.h,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    weaponsList.toString(),
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14.h,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'ステージ：${match.stage}',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14.h,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}

class EmptyMatchTile extends StatelessWidget {
  const EmptyMatchTile({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      height: 188.h,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black54,
          width: 2.h,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16.w)),
      ),
      child: Center(
        child: SizedBox(
          height: 20.h,
          width: 20.w,
          child: Text(text),
        ),
      ),
    );
  }
}
