import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ulearning_app/pages/sign_in/bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == 'email') {
        // BlocProvider.of<SignInBloc>(context).state;
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if(emailAddress.isEmpty) {
          //
        }
        if(password.isEmpty) {
          //
        }

        try {
          final credential = await FirebaseAuth
              .instance.signInWithEmailAndPassword(
              email: emailAddress, password: password);

          if (credential.user == null) { // user is not exist
            //
          }
          if (!credential.user!.emailVerified) { // email is not verified
            //
          }
          var user =  credential.user;
          if(user != null) {
            // we got verified user from Firebase
          } else {
            // we have error getting user from firebase
          }
        } catch (e) {

        }

      }
    } catch(e) {

    }
  }
}