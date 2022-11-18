import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:splooking3/app.dart';
import 'package:splooking3/auth/mail_login.dart';
import 'package:splooking3/auth/user_auth.dart';
import 'package:splooking3/components/buttons.dart';
import 'package:splooking3/components/colors.dart';
import 'package:splooking3/components/text_fields.dart';
import 'package:splooking3/components/texts.dart';
import 'package:splooking3/pages/profile_regist_page.dart';
import 'package:splooking3/util/show_dialog.dart';

final emailControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final passwordControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final emailHintTextProvider = StateProvider<String>((ref) => 'メールアドレス');
final passwordHintTextProvider = StateProvider<String>((ref) => 'パスワード');
final errorTextProvider = StateProvider<String>((ref) => '');

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final errorText = ref.watch(errorTextProvider);
    final emailHintText = ref.watch(emailHintTextProvider);
    final passwordHintText = ref.watch(passwordHintTextProvider);
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final currentUser = ref.watch(currentUserProvider);

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

    Future<void> getUserData({required String uid}) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .get()
          .then((value) {
        if (!value.exists) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileRegistPage(),
            ),
          );
        } else {
          currentUser
            ..name = value.data()!['name']
            ..id = uid
            ..avatar = value.data()!['avatarUrl'].toString()
            ..friendCode = value.data()!['friendCode']
            ..weapons = value.data()!['weapons']
            ..description = value.data()!['description']
            ..rank = value.data()!['rank']
            ..udemae = value.data()!['udemae']
            ..xp = value.data()!['xp'];
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 92.h,
                width: 340.w,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 300.w,
                child: Column(
                  children: [
                    SizedBox(
                      height: 104.h,
                    ),
                    SizedBox(
                      height: 36.h,
                      width: 300.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: const Head1(text: 'LOG IN'),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    UnderLinedTextField(
                      controller:
                          ref.read(emailControllerProvider.notifier).state,
                      focusNode: emailFocusNode,
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: splatoonColorPink,
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
                        color: splatoonColorGreen,
                      ),
                      isPassword: true,
                      hintText: passwordHintText,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 144.h),
                    OutLinedButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 52.w,
                      ),
                      onTaped: () async {
                        ref.read(errorTextProvider.notifier).state =
                            await loginWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        if (errorText.isNotEmpty) {
                          showErrorAlertDialog(
                            context: context,
                            errorText: errorText,
                          );
                        } else {
                          final currentUserUid =
                              FirebaseAuth.instance.currentUser?.uid;
                          getUserData(uid: currentUserUid!);
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScreenContainer()));
                        }
                      },
                      child: Text(
                        'ログイン',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 241, 241, 241),
                          fontSize: 16.w,
                          letterSpacing: 4.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
