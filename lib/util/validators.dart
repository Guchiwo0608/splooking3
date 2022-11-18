import 'package:email_validator/email_validator.dart';

String emailValidator(String? email) {
  if (email == null) {
    return 'メールアドレスが空です。';
  } else {
    if (email.isEmpty) {
      return 'メールアドレスを入力してください。';
    } else {
      if (!EmailValidator.validate(email)) {
        return '正しいメールアドレスを入力してください。';
      } else {
        return '';
      }
    }
  }
}

String passwordValidator(String? password) {
  if (password == null) {
    return 'パスワードが空です。';
  } else {
    if (password.isEmpty) {
      return 'パスワードを入力してください。';
    } else {
      if (!RegExp(r'[a-zA-Z0-9]+').hasMatch(password)) {
        return '不正なパスワードです。';
      } else {
        if (password.length < 8) {
          return 'パスワードは8文字以上にしてください。';
        } else {
          if (password.length > 16){
            return 'パスワードは16文字以下にしてください。';
          }
          return '';
        }
      }
    }
  }
}