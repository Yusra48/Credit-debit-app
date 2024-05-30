import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/LoginView.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  void goToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    return GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.displayLarge,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black,
    );
  }

  TextStyle _getSubtitleTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.black,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF527A8D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'images/creditdebit.json',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              onLoaded: (composition) {
                Future.delayed(const Duration(seconds: 2), goToNextScreen);
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Mobile Banking',
              style: _getTitleTextStyle(context),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Know your credit and debit and financial habits in your control',
                style: _getSubtitleTextStyle(context),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 140),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF04378F),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 190.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
