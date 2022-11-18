import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/auth/mail_signup.dart';
import 'package:splooking3/components/buttons.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/text_fields.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/pages/login_page.dart';
import 'package:splooking3/pages/profile_regist_page.dart';
import 'package:splooking3/util/show_dialog.dart';
import 'package:splooking3/util/validators.dart';

final emailControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final emailHintTextProvider = StateProvider<String>((ref) => 'メールアドレス');
final passwordControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final passwordHintTextProvider = StateProvider<String>((ref) => 'パスワード');
final isCollectPasswordLengthProvider = StateProvider<bool>((ref) => false);
final isCollectPasswordLetterProvider = StateProvider<bool>((ref) => false);
final errorTextProvider = StateProvider<String>((ref) => '');

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final emailHintText = ref.watch(emailHintTextProvider);
    final passwordHintText = ref.watch(passwordHintTextProvider);
    final isCollectPasswordLength = ref.watch(isCollectPasswordLengthProvider);
    final isCollectPasswordLetter = ref.watch(isCollectPasswordLetterProvider);
    final errorText = ref.watch(errorTextProvider);

    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        ref.read(emailHintTextProvider.notifier).state = '';
      } else {
        ref.read(emailHintTextProvider.notifier).state = 'メールアドレス';
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        ref.read(passwordHintTextProvider.notifier).state = '';
      } else {
        ref.read(passwordHintTextProvider.notifier).state = 'パスワード';
      }
    });

    void onChangePasswordValidator() {
      final validateResult = passwordValidator(passwordController.text);
      ref.watch(isCollectPasswordLengthProvider.notifier).state =
          !(validateResult == 'パスワードは8文字以上にしてください。' ||
              validateResult == 'パスワードは16文字以下にしてください。');
      ref.watch(isCollectPasswordLetterProvider.notifier).state =
          !(validateResult == '不正なパスワードです。');
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300.w,
            child: Column(
              children: [
                SizedBox(
                  height: 124.h,
                ),
                SizedBox(
                  height: 36.h,
                  width: 300.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: const Head1(text: 'SIGN UP'),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                UnderLinedTextField(
                  controller: ref.read(emailControllerProvider.notifier).state,
                  focusNode: emailFocusNode,
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: splatoonColorBlue,
                  ),
                  hintText: emailHintText,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 28.h,
                ),
                UnderLinedTextField(
                  controller:
                      ref.read(passwordControllerProvider.notifier).state,
                  focusNode: passwordFocusNode,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: splatoonColorYellow,
                  ),
                  isPassword: true,
                  hintText: passwordHintText,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    onChangePasswordValidator();
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 100.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: HelperTextWidget(
                          condition: isCollectPasswordLength,
                          text: '8文字以上16文字以下',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: HelperTextWidget(
                          condition: isCollectPasswordLetter,
                          text: '半角英字（大文字を含む）、数字を使用',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),
                OutLinedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 68.w,
                  ),
                  onTaped: () async {
                    if ((ref.read(errorTextProvider.notifier).state =
                            await signUpWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    ))
                        .isNotEmpty) {
                      showErrorAlertDialog(
                        context: context,
                        errorText: errorText,
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileRegistPage(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '登録',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 241, 241, 241),
                      fontSize: 16.w,
                      letterSpacing: 10.w,
                    ),
                  ),
                ),
                SizedBox(height: 52.h),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'ログインはこちら',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
