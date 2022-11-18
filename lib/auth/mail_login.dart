import 'package:firebase_auth/firebase_auth.dart';

Future<String> loginWithEmailAndPassword({
  required String? email,
  required String? password,
}) async {
  try {
    if (email == null) {
      return 'メールアドレスが空です。';
    } else {
      if (email.isEmpty) {
        return 'メールアドレスを入力してください。';
      } else {
        if (password == null) {
          return 'パスワードが空です。';
        } else {
          if (password.isEmpty) {
            return 'パスワードを入力してください。';
          } else {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
            return '';
          }
        }
      }
    }
  } catch (error) {
    return 'メールアドレスまたはパスワード、もしくは両方が間違っています。';
  }
}
