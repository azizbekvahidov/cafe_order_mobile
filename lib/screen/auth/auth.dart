import 'dart:io';

import 'package:cafe_mostbyte/bloc/auth/auth_repository.dart';
import 'package:cafe_mostbyte/generated/locale_base.dart';
import 'package:cafe_mostbyte/screen/moderator_screen.dart';
import 'package:cafe_mostbyte/screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../config/globals.dart' as globals;

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Duration get loginTime => Duration(milliseconds: 2250);
  AuthRepository authRepo = AuthRepository();

  Future<String?> _authUser(LoginData data) {
    authRepo.login(login: data.name, pass: data.password);
    return Future.delayed(loginTime).then((_) {
      if (globals.userData == null) {
        return 'User not exists';
      }
      return null;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            exit(0);
          },
          child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(8),
              child: Icon(
                SimpleLineIcons.power,
                color: Theme.of(context).primaryColor,
                size: 30,
              )),
        ),
      ),
      body: FlutterLogin(
        userValidator: (value) {},
        title: '',
        logo: AssetImage('assets/img/logo.png'),
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => (globals.userData!.role.role == "moderator")
                ? ModeratorScreen()
                : OrderScreen(),
          ));
        },
        hideForgotPasswordButton: true,
        onRecoverPassword: _recoverPassword,
        messages: LoginMessages(
          userHint: loc.auth.login,
          passwordHint: loc.auth.password,
          // confirmPasswordHint: 'Confirm',
          loginButton: loc.auth.log_in,
          signupButton: '',
          // forgotPasswordButton: 'Forgot huh?',
          // recoverPasswordButton: 'HELP ME',
          goBackButton: loc.auth.go_back,
          // confirmPasswordError: 'Not match!',
          // recoverPasswordDescription:
          //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
          // recoverPasswordSuccess: 'Password rescued successfully',
        ),
        theme: LoginTheme(
          titleStyle: Theme.of(context).textTheme.headline1,
          buttonStyle: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
