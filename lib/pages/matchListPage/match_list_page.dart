import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/components/bottom_navigation_bar.dart';
import 'package:splooking3/components/buttons.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/match_tile.dart';
import 'package:splooking3/components/text_fields.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/data/match.dart' as data;
import 'package:splooking3/pages/createNewMatchPages/select_match_type.dart';
import 'package:splooking3/pages/matchListPage/matchDetailPage/match_detail_page.dart';
import 'package:splooking3/util/get_match_list.dart';

final searchControllerProvider =
    StateProvider.autoDispose<TextEditingController>(
        (ref) => TextEditingController());

class MatchListPage extends HookConsumerWidget {
  const MatchListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchListStream = getMatchList();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: matchListStream,
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: backgroundColor,
                title: Row(
                  children: [
                    SizedBox(width: 30.w),
                    Icon(
                      Icons.amp_stories_outlined,
                      size: 32.w,
                      color: Colors.black,
                    ),
                    SizedBox(width: 30.w),
                    const Head2(text: 'Match List'),
                  ],
                ),
                elevation: 0,
              ),
              body: Center(
                child: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.none) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: backgroundColor,
              title: Row(
                children: [
                  SizedBox(width: 30.w),
                  Icon(
                    Icons.amp_stories_outlined,
                    size: 32.w,
                    color: Colors.black,
                  ),
                  SizedBox(width: 30.w),
                  const Head2(text: 'Match List'),
                ],
              ),
              elevation: 0,
            ),
            body: SizedBox(
              height: 500.h,
              child: Center(
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
            ),
          );
        }

        if (snapshot.data == null || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: backgroundColor,
              title: Row(
                children: [
                  SizedBox(width: 30.w),
                  Icon(
                    Icons.amp_stories_outlined,
                    size: 32.w,
                    color: Colors.black,
                  ),
                  SizedBox(width: 30.w),
                  const Head2(text: 'Match List'),
                ],
              ),
              elevation: 0,
            ),
            body: SizedBox(
              height: 500.h,
              child: Center(
                child: Column(
                  children: [
                    const Head4(
                      text: 'データが存在しません',
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
            ),
          );
        } else {
          final matchList = toMatchList(snapshot.data!.docs);
          return MatchListPageView(matchList: matchList);
        }
      },
    );
  }
}

class MatchListPageView extends HookConsumerWidget {
  const MatchListPageView({
    Key? key,
    required this.matchList,
  }) : super(key: key);

  final List<data.Match> matchList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchControllerProvider);

    List<Widget> getMatchTileList(List<data.Match> matchList) {
      final List<Widget> matchTileList = [];
      for (int i = 0; i < matchList.length; i++) {
        final Widget tile;
        if (matchList[i] is data.PublicMatch) {
          tile = PublicMatchTile(match: matchList[i] as data.PublicMatch);
        } else if (matchList[i] is data.PrivateMatch) {
          tile = PrivateMatchTile(match: matchList[i] as data.PrivateMatch);
        } else {
          tile = SalmonRunMatchTile(match: matchList[i] as data.SalmonrunMatch);
        }
        matchTileList.add(
          GestureDetector(
            child: tile,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MatchDetailPage(index: i)));
            },
          ),
        );
      }
      return matchTileList;
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            SizedBox(width: 30.w),
            Icon(
              Icons.amp_stories_outlined,
              size: 32.w,
              color: Colors.black,
            ),
            SizedBox(width: 30.w),
            const Head2(text: 'Match List'),
            SizedBox(width: 80.w),
            GestureDetector(
              child: Icon(
                Icons.add,
                size: 32.w,
                color: const Color.fromARGB(255, 31, 209, 0),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateNewMatchPage()),
                );
              },
            )
          ],
        ),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: backgroundColor,
            floating: true,
            title: SizedBox(
              width: 360.w,
              height: 40.h,
              child: OutLinedTextField(
                controller: searchController,
                maxLines: 1,
                backgroundColor: Colors.grey[100],
                borderColor: Colors.black,
                prefixIcon: const Icon(
                  Icons.search,
                  color: splatoonColorPink,
                ),
                textAlignVertical: TextAlignVertical.top,
                textInputAction: TextInputAction.search,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: getMatchTileList(matchList),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(index: 0),
    );
  }
}
