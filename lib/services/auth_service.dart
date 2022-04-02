// ignore_for_file: avoid_print, dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

//--------------------------------------------------------------------------------------------------//
//                                             SIGN UP                                              //
//--------------------------------------------------------------------------------------------------//

  registerWithEmail({required String email, required String password}) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Kullandiginiz parola zayif');
      } else if (e.code == 'email-already-in-use') {
        print('Email zaten kullaniliyor');
      }
    } catch (e) {
      print(e);
    }
  }

//--------------------------------------------------------------------------------------------------//
//                                             SIGN IN                                              //
//--------------------------------------------------------------------------------------------------//

  // ignore: body_might_complete_normally_nullable
  Future loginWithMail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
      print('Kullanici Giris Yapti. ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   print('Girdiginiz bilgilerle eslesen bir kullanici bulunamadi');
      // } else if (e.code == 'wrong-password') {
      //   print('Yanlis veya hatali sifre girdiniz');
      // }
      return e.message;
    } catch (e) {
      print(e);
    }
  }

//--------------------------------------------------------------------------------------------------//
//                                           RESET PASSWORD                                         //
//--------------------------------------------------------------------------------------------------//

  Future passwordResetWithMail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Parola sifirlama maili gonderildi');
    } catch (e) {
      print(e.toString());
    }
  }

//--------------------------------------------------------------------------------------------------//
//                                           SIGN OOUT                                              //
//--------------------------------------------------------------------------------------------------//

  Future signOut() async {
    await _auth.signOut();

    print('sign out');
  }

//--------------------------------------------------------------------------------------------------//
//                                   SIGN IN WITH GOOGLE                                            //
//--------------------------------------------------------------------------------------------------//

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }
}
