// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:chothuexemay_owner/Repositories/Implementations/owner_repository.dart';
import 'package:chothuexemay_owner/views/Login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInViewModel extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  final OwnerRepository _ownerRepository = OwnerRepository();

  Future<int> googleLogin({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    GoogleSignInAuthentication googleSignInAuthentication;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        var accessToken = await userCredential.user!.getIdToken();
        int statusCode = await _ownerRepository.login(user!.uid, accessToken);
        if (statusCode == 404) {
          final code = await _ownerRepository.register(
              user.email!, accessToken, user.displayName!);
          if (code == 200) {
            return 1;
          } else {
            return -1;
          }
        }
        return statusCode;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Fluttertoast.showToast(
            msg: "T??i kho???n kh??ng h???p l???",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT,
          );
          log('The account already exists with a different credential.');
        } else if (e.code == 'invalid-credential') {
          log('Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        log('Error occurred using Google Sign-In. Try again.');
      }
    }
    notifyListeners();
    return -1;
  }

  Future signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginView(),
        ),
        (route) => false,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "X???y ra l???i, vui l??ng th??? l???i",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
