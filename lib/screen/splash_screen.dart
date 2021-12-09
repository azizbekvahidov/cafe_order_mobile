import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff42a5f5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
            Padding(padding: const EdgeInsets.only(top: 50)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SvgPicture.asset(
                "assets/img/logo-cafe.svg",
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
