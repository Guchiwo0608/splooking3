import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/components/buttons.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/dropdown_button.dart';
import 'package:splooking3/components/text_fields.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/data/schedule.dart';
import 'package:splooking3/pages/createNewMatchPages/select_match_type.dart';
import 'package:splooking3/util/get_schedule.dart/get_schedule_from_api.dart';
import 'package:splooking3/util/show_datetime_picker.dart';

class SetMatchDetailPage extends HookConsumerWidget {
  const SetMatchDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchType = ref.watch(matchTypeValueProvider);
    final matchNameController = useState(TextEditingController());
    final peopleNumberProvider = StateProvider((ref) => -1);
    final peopleNumber = ref.watch(peopleNumberProvider);
    final startTimeProvider =
        StateProvider((ref) => DateTime(2022, 1, 1, 0, 0));
    final startTime = ref.watch(startTimeProvider);
    final scheduleListProvider = StateProvider(
      (ref) => ScheduleList(
        openMatchScheduleList: [],
        regularMatchScheduleList: [],
        leagueMatchScheduleList: [],
      ),
    );

    const dropdownListMap = {
      'バンカラマッチ(オープン)': ['選択してください。', 1, 2, 3],
      'リーグマッチ': ['選択してください。', 1, 3],
      'レギュラーマッチ': ['選択してください。', 1, 2, 3],
      'プライベートマッチ': ['選択してください。', 1, 2, 3, 4, 5, 6, 7, 8, 9],
      'サーモンラン': ['選択してください。', 1, 2, 3],
    };

    return Scaffold(
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
          width: 332.w,
          child: Column(
            children: [
              SizedBox(height: 8.h),
              SizedBox(
                width: 332.w,
                child: const Head5(text: '・マッチの種類 :'),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.w,
                  horizontal: 16.h,
                ),
                margin: EdgeInsets.symmetric(vertical: 8.w),
                decoration: BoxDecoration(
                  color: colorMap[matchType],
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                ),
                child: Head4(text: matchType!),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 332.w,
                child: const Head5(text: '・マッチ名 :'),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.w,
                  horizontal: 16.h,
                ),
                child: UnderLinedTextField(
                  controller: matchNameController.value,
                  maxLength: 12,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 332.w,
                child: const Head5(text: '・募集人数 :'),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.w,
                  horizontal: 16.h,
                ),
                child: SplookingDropdownButton(
                  dropdownList: dropdownListMap[matchType]!,
                  dropdownValueProvider: peopleNumberProvider,
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 332.w,
                child: const Head5(text: '・開始時間 :'),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Head3(
                  // ignore: prefer_adjacent_string_concatenation
                  text: '${startTime.year}年' +
                      '${startTime.month}月' +
                      '${startTime.day}日' +
                      '${startTime.hour}時' +
                      '${startTime.minute}分',
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.w,
                  horizontal: 16.h,
                ),
                child: OutLinedButton(
                  child: const Head5(
                    text: '時間を選択する',
                    color: Color.fromARGB(237, 255, 255, 255),
                  ),
                  onTaped: () async {
                    await showPickerDateTime(
                      context,
                      onConfirm: (picker, value) {
                        ref.read(startTimeProvider.notifier).state =
                            DateTime.parse(picker.adapter.text);
                        print(picker.adapter.text);
                        print(startTime);
                      },
                    );
                  },
                ),
              ),
              Container(
                child: const Body1(text: 'または'),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.w,
                  horizontal: 16.h,
                ),
                child: OutLinedButton(
                  color: const Color.fromARGB(255, 64, 105, 66),
                  child: const Head5(
                    text: 'スケジュールを選択する',
                    color: Color.fromARGB(237, 255, 255, 255),
                  ),
                  onTaped: () async {
                    final a = await getScheduleList();
                    print(a.leagueMatchScheduleList.toString());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
