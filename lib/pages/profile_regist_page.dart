import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/app.dart';
import 'package:splooking3/auth/user_auth.dart';
import 'package:splooking3/components/buttons.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/text_fields.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/components/widgets.dart';
import 'package:splooking3/util/profile_update.dart';
import 'package:splooking3/util/show_dialog.dart';

final userNameControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final avatarProvider = StateProvider<String>((ref) => '');
final friendCodeControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final descriptionControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final userNameHintTextProvider = StateProvider<String>((ref) => 'ユーザーネーム（必須）');
final friendCodeHintTextProvider = StateProvider<String>((ref) => 'フレンドコード');

class ProfileRegistPage extends HookConsumerWidget {
  const ProfileRegistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAuth = ref.watch(currentUserAuthProvider);
    final userNameController = ref.watch(userNameControllerProvider);
    final avatar = ref.watch(avatarProvider);
    final friendCodeController = ref.watch(friendCodeControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);
    final userNameHintText = ref.watch(userNameHintTextProvider);
    final friendCodeHintText = ref.watch(friendCodeHintTextProvider);
    final userNameFocusNode = useFocusNode();
    final friendCodeFocusNode = useFocusNode();
    final currentUser = ref.watch(currentUserProvider);

    Future<void> initUser() async {
      ref.read(currentUserProvider.notifier).state.name =
          userNameController.text;
      ref.read(currentUserProvider.notifier).state.avatar = avatar;
      ref.read(currentUserProvider.notifier).state.id =
          currentUserAuth.value!.uid;
      ref.read(currentUserProvider.notifier).state.friendCode =
          friendCodeController.text;
      ref.read(currentUserProvider.notifier).state.description =
          descriptionController.text;
    }

    userNameFocusNode.addListener(() {
      if (userNameFocusNode.hasFocus) {
        ref.read(userNameHintTextProvider.notifier).state = '';
      } else {
        ref.read(userNameHintTextProvider.notifier).state = 'ユーザーネーム（必須）';
      }
    });

    friendCodeFocusNode.addListener(() {
      if (friendCodeFocusNode.hasFocus) {
        ref.read(friendCodeHintTextProvider.notifier).state = '';
      } else {
        ref.read(friendCodeHintTextProvider.notifier).state = 'フレンドコード';
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 12.w),
            BackButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.grey[700],
            ),
            SizedBox(width: 12.w),
            const Head3(text: 'プロフィール設定'),
          ],
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 340.w,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  SizedBox(
                    height: 112.h,
                    width: 112.w,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(6.w),
                          child: ProfileAvatar(
                            radius: 76.h,
                            borderColor: Colors.grey[700]!,
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.85, 0.85),
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.h,
                                ),
                                borderRadius: BorderRadius.circular(20.w),
                              ),
                              child: CircleAvatar(
                                backgroundColor: const Color(0xAF9E9E9E),
                                radius: 16.w,
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48.h),
                  SizedBox(
                    width: 300.w,
                    child: UnderLinedTextField(
                      controller:
                          ref.read(userNameControllerProvider.notifier).state,
                      prefixIcon: const Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: splatoonColorGreen,
                      ),
                      hintText: userNameHintText,
                      focusNode: userNameFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  SizedBox(
                    width: 300.w,
                    child: UnderLinedTextField(
                      controller:
                          ref.read(friendCodeControllerProvider.notifier).state,
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 14.h, 15.w, 14.h),
                        child: const Image(
                          image: AssetImage('assets/switch_icon.png'),
                          color: Color(0xFFe60012),
                          width: 8,
                          height: 8,
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      hintText: friendCodeHintText,
                      focusNode: friendCodeFocusNode,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  SizedBox(
                    width: 300.w,
                    child: Head4(
                      text: '自己紹介',
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 300.w,
                    child: OutLinedTextField(
                      controller: ref
                          .read(descriptionControllerProvider.notifier)
                          .state,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      maxLength: 120,
                      maxLines: 4,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: 40.h),
                  OutLinedButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 52.w,
                    ),
                    onTaped: () async {
                      await initUser();
                      final errorText = await profileUpdate(user: currentUser);
                      if (errorText.isNotEmpty) {
                        showErrorAlertDialog(
                          context: context,
                          errorText: errorText,
                        );
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const ScreenContainer()),
                        );
                      }
                    },
                    child: Text(
                      '保存',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF444444),
                        fontSize: 16.w,
                        letterSpacing: 4.w,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
