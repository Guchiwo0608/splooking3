import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/app.dart';
import 'package:splooking3/components/colors.dart';

final List<Color> bottomNavSelectedColor = [
  splatoonColorPink,
  splatoonColorGreen,
  splatoonColorYellow
];

class BottomNav extends HookConsumerWidget {
  const BottomNav({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 104.h,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5.h)),
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: 'Match'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
        currentIndex: index,
        onTap: (currentTabType) {
          ref.read(tabtypeProvider.notifier).state
            = Tabtype.values[currentTabType];
        },
        elevation: 0,
        iconSize: 24.w,
        selectedFontSize: 14.w,
        unselectedFontSize: 12.w,
        backgroundColor: Colors.white,
        selectedItemColor: bottomNavSelectedColor[index],
        unselectedItemColor: Colors.grey[700],
      ),
    );
  }
}
