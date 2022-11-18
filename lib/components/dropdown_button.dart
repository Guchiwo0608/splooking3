import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/components/texts.dart';

class SplookingDropdownButton extends HookConsumerWidget {
  const SplookingDropdownButton({
    super.key,
    required this.dropdownList,
    required this.dropdownValueProvider,
  });

  final List<dynamic> dropdownList;
  final StateProvider dropdownValueProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValue = useState<dynamic>('選択してください。');
    final isSelected = useState(false);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[350]!,
          width: 4.w,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: DropdownButton(
        elevation: 12,
        underline: Container(),
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
        iconSize: 32.w,
        value: dropdownValue.value,
        items: dropdownList.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Head5(text: e.toString()),
            onTap: () {
              if (e != '選択してください。') {
                isSelected.value = true;
              }
            },
          );
        }).toList(),
        onChanged: (value) {
          dropdownValue.value = value;
          ref.read(dropdownValueProvider.notifier).state = value;
        },
      ),
    );
  }
}
