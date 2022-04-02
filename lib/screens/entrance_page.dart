import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../services/auth_service.dart';
import 'home_page.dart';
import 'signup_login_page.dart';

class EntrancePage extends StatelessWidget {
  const EntrancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wallet_bg4.png'),
              fit: BoxFit.scaleDown,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SignInButton(
                Buttons.Google,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

//--------------------------------------------------------------------------------------------------//
//                                      SIGN IN WITH GOOGLE                                         //
//--------------------------------------------------------------------------------------------------//

                onPressed: () {
                  MyAuthService().signInWithGoogle().then((value) {
                    if (value != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SignInButtonBuilder(
                text: 'Sign in with Email',
                padding: const EdgeInsets.all(15),
                icon: Icons.email,
                backgroundColor: Colors.blueGrey.shade700,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpLoginPage(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
