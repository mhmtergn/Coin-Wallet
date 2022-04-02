// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../constant/constant.dart';
import '../services/auth_service.dart';
import 'entrance_page.dart';
import 'home_page.dart';

class SignUpLoginPage extends StatefulWidget {
  const SignUpLoginPage({Key? key}) : super(key: key);

  @override
  State<SignUpLoginPage> createState() => _SignUpLoginPageState();
}

class _SignUpLoginPageState extends State<SignUpLoginPage> {
  String? email;
  String? password;
  String? rePassword;
  String? emailReset;

  bool isSignUpScreen = true;
  bool isClicked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colour.inactiveButtonColor),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUpScreen = true;
                          });
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colour.inactiveButtonColor, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: isSignUpScreen
                                ? Colors.white
                                : Colour.inactiveButtonColor,
                          ),
                          child: Text(
                            'Sign up',
                            style: isSignUpScreen
                                ? kChosenButtonTextStyle
                                : kUnChosenButtonTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignUpScreen = false;
                          });
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colour.inactiveButtonColor, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: !isSignUpScreen
                                ? Colors.white
                                : Colour.inactiveButtonColor,
                          ),
                          child: Text(
                            'Sign in',
                            style: !isSignUpScreen
                                ? kChosenButtonTextStyle
                                : kUnChosenButtonTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isSignUpScreen ? signUpSection() : signInSection(),
            ],
          ),
        ),
      ),
    );
  }

//--------------------------------------------------------------------------------------------------//
//                                      SIGN IN SECTION                                             //
//--------------------------------------------------------------------------------------------------//

  Column signInSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email'),
        const SizedBox(
          height: 3,
        ),
        SizedBox(
          height: 52,
          child: TextField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            style: const TextStyle(fontSize: 17),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Password'),
        const SizedBox(
          height: 3,
        ),
        // textField(
        //   const Icon(Icons.visibility),
        // ),
        SizedBox(
          height: 52,
          child: TextField(
            onChanged: (value) => password = value,
            obscureText: isClicked ? true : false,
            style: const TextStyle(fontSize: 17),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isClicked = !isClicked;
                    });
                  },
                  icon: const Icon(Icons.visibility)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
          child: TextButton(
//--------------------------------------------------------------------------------------------------//
//                                      SHOW MODAL BOTTOM SHEET                                     //
//--------------------------------------------------------------------------------------------------//

            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        onChanged: (email) => emailReset = email,
                        decoration: InputDecoration(
                          hintText: 'E mail Adress',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
//--------------------------------------------------------------------------------------------------//
//                                       PASSWORD RESET                                             //
//--------------------------------------------------------------------------------------------------//

                      onPressed: () {
                        if (emailReset != null) {
                          MyAuthService()
                              .passwordResetWithMail(email: emailReset!);
                        } else {
                          print('email : $emailReset');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                          left: 140,
                          right: 140,
                          top: 15,
                          bottom: 15,
                        ),
                        primary: Colour.blueButtonColor,
                      ),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Forgot Password ?',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                )),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          height: 100,
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
//--------------------------------------------------------------------------------------------------//
//                                      LOGIN WITH MAIL                                             //
//--------------------------------------------------------------------------------------------------//

            onPressed: () {
              if (email != null && password != null) {
                MyAuthService()
                    .loginWithMail(email: email!, password: password!)
                    .then((user) {
                  if (user == null) {
                    print('user null degil');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const HomePage()),
                      ),
                    );
                  } else {
                    print('user null');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const EntrancePage()),
                      ),
                    );
                  }
                });
              } else {
                print('email : $email , password: $password');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                left: 140,
                right: 140,
                top: 15,
                bottom: 15,
              ),
              primary: Colors.blueGrey,
            ),
            child: const Text(
              'Continue',
            ),
          ),
        ),
      ],
    );
  }

//--------------------------------------------------------------------------------------------------//
//                                      SIGN UP SECTION                                             //
//--------------------------------------------------------------------------------------------------//

  Column signUpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email'),
        const SizedBox(
          height: 3,
        ),
        SizedBox(
          height: 52,
          child: TextField(
            onChanged: (value) => email = value,
            style: const TextStyle(fontSize: 17),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Create Password'),
        const SizedBox(
          height: 3,
        ),
        SizedBox(
          height: 52,
          child: TextField(
            onChanged: (value) => password = value,
            obscureText: isClicked ? true : false,
            style: const TextStyle(fontSize: 17),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isClicked = !isClicked;
                    });
                  },
                  icon: const Icon(Icons.visibility)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('Re-write Password'),
        const SizedBox(
          height: 3,
        ),
        textField(
          const Icon(Icons.watch_later),
        ),
        const SizedBox(
          height: 50,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text:
                  'Curabitur lobortis id lorem id bibendum. Ut id consectetur magna.',
              style: TextStyle(color: Colors.grey.shade600),
              children: const [
                TextSpan(
                  text: 'Terms of Use ',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: 'augune enim, pulvinar'),
                TextSpan(
                  text: ' Privacy Notice ',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: 'lacinia at.',
                ),
              ]),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 100,
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
//--------------------------------------------------------------------------------------------------//
//                                      REGISTER WITH MAIL                                          //
//--------------------------------------------------------------------------------------------------//

            onPressed: () {
              if (email != null && password != null) {
                MyAuthService()
                    .registerWithEmail(email: email!, password: password!);
              } else {
                print('Bir hata olustu. email : $email , password : $password');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                left: 140,
                right: 140,
                top: 15,
                bottom: 15,
              ),
              primary: Colors.blueGrey,
            ),
            child: const Text(
              'Continue',
            ),
          ),
        ),
      ],
    );
  }

//--------------------------------------------------------------------------------------------------//
//                                      TEXTFIELD METHOD                                            //
//--------------------------------------------------------------------------------------------------//

  SizedBox textField([
    Icon? icon,
  ]) {
    return SizedBox(
      height: 52,
      child: TextField(
        // onChanged: onChangedFunc,
        obscureText: isClicked ? true : false,
        style: const TextStyle(fontSize: 17),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isClicked = !isClicked;
                });
              },
              icon: const Icon(Icons.visibility)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Container signUpSignInContainer(String title) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colour.inactiveButtonColor, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: isSignUpScreen ? Colors.white : Colour.inactiveButtonColor,
      ),
      child: Text(
        title,
        style: kBoldTextStyle,
      ),
    );
  }
}
