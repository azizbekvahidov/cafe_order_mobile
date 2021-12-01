import 'package:cafe_mostbyte/generated/locale_base.dart';
import 'package:cafe_mostbyte/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    // debugPrint('Name: ${data.name}, Password: ${data.password}');
    // return Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(data.name)) {
    //     return 'User not exists';
    //   }
    //   if (users[data.name] != data.password) {
    //     return 'Password does not match';
    //   }
    //   return null;
    // });
    return Future.delayed(loginTime).then((_) {
      return 'User not exists';
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    // debugPrint('Name: $name');
    // return Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(name)) {
    //     return 'User not exists';
    //   }
    //   return null;
    // });
    return Future.delayed(loginTime).then((_) {
      return 'User not exists';
    });
  }

  @override
  Widget build(BuildContext context) {
    var loc = Localizations.of<LocaleBase>(context, LocaleBase)!;
    return FlutterLogin(
      title: 'ECORP',
      logo: AssetImage('assets/img/logo.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      },
      userValidator: (value) {
        print("goo");
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        userHint: loc.auth.login,
        passwordHint: loc.auth.password,
        // confirmPasswordHint: 'Confirm',
        loginButton: loc.auth.log_in,
        // signupButton: 'REGISTER',
        // forgotPasswordButton: 'Forgot huh?',
        // recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        // confirmPasswordError: 'Not match!',
        // recoverPasswordDescription:
        //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        // recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }
}
