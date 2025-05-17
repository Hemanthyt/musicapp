import 'package:client/core/theme/app_pallate.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              const CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('assets/images/dj.jpg'),
              ),
              const Spacer(),
              const Text(
                'Listen to music \n Everywhere you want',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
                child: Text(
                  'Listen music everywhere to \n boost your day ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Pallete.whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Container(
                width: 280,
                decoration: BoxDecoration(
                    boxShadow: const [
                      // apply box shadow that cover till the bottom for the above gradient color?
                      BoxShadow(
                          color: Color.fromARGB(
                              149, 251, 109, 168), // shadow color
                          spreadRadius: 0,
                          blurRadius: 1000,
                          offset: Offset(-40, 100),
                          blurStyle: BlurStyle.normal),
                      BoxShadow(
                          color: Color.fromARGB(
                              102, 251, 109, 168), // shadow color
                          spreadRadius: 0,
                          blurRadius: 100,
                          offset: Offset(-20, 90),
                          blurStyle: BlurStyle.normal),
                      BoxShadow(
                          color:
                              Color.fromARGB(93, 61, 220, 248), // shadow color
                          spreadRadius: 0,
                          blurRadius: 100,
                          offset: Offset(20, 90),
                          blurStyle: BlurStyle.normal),

                      BoxShadow(
                          color:
                              Color.fromARGB(139, 7, 163, 241), // shadow color
                          spreadRadius: 0,
                          blurRadius: 1000,
                          offset: Offset(40, 100),
                          blurStyle: BlurStyle.normal
                          // adjust the offset to cover the bottom part
                          ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Pallete.gradient2,
                        Color.fromARGB(255, 7, 163, 241),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateColor.transparent,
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                      (_) => false,
                    );
                  },
                  child: const Row(
                    children: [
                      Spacer(),
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
