import 'package:firebase_auth/firebase_auth.dart';
import 'package:splooking3/util/validators.dart';

Future<String> signUpWithEmailAndPassword({
  required String email,
  required String password,
}) async {
  try {
    final emailErrorText = emailValidator(email);
    final passwordErrorText = passwordValidator(password);
    if (emailErrorText.isEmpty && passwordErrorText.isEmpty) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return '';
    } else {
      if (emailErrorText.isNotEmpty) {
        return emailErrorText;
      }
      return passwordErrorText;
    }
  } on FirebaseAuthException catch (error) {
    if (error.code == 'email-already-in-use') {
      return 'このメールアドレスはすでに使用されています。';
    }
    return '予期せぬエラーが発生しました。';
  }
}
