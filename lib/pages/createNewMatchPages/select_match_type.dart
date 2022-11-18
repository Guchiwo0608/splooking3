import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/components/buttons.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/constants.dart';
import 'package:splooking3/components/dropdown_button.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/pages/createNewMatchPages/set_match_detail.dart';
import 'package:splooking3/util/show_dialog.dart';

final matchTypeValueProvider = StateProvider<String?>((ref) => '選択してください。');

final dropdownItemList = ['選択してください。'] + matchTypeList;

class CreateNewMatchPage extends HookConsumerWidget {
  const CreateNewMatchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchTypeValue = ref.watch(matchTypeValueProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
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
              child: const Head3(text: 'New Match'),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          height: 240.h,
          width: 300.w,
          child: Column(
            children: [
              const Head3(text: 'マッチの種類は？'),
              SizedBox(height: 20.h),
              SplookingDropdownButton(
                dropdownList: dropdownItemList,
                dropdownValueProvider: matchTypeValueProvider,
              ),
              SizedBox(height: 60.h),
              OutLinedButton(
                child: const Head5(text: '次へ'),
                color: Colors.lightGreen[200]!,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                onTaped: () {
                  if (matchTypeValue != '選択してください。') {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SetMatchDetailPage();
                    }));
                  } else {
                    showErrorAlertDialog(
                      context: context,
                      errorText: 'マッチの種類を選択してください。',
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
