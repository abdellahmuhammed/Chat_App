import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future userLogin(
    context, {
    required userEmail,
    required userPassword,
  }) async {
    emit(LoginIsLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      debugPrint('create User Login Successfully');

      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailureState(
            errorMessage: 'Wrong password provided for that user.'));
      } else {
        emit(
            LoginFailureState(errorMessage: 'Email or password is incorrect.'));
      }
    } on Exception catch (e) {
      debugPrint('error happened when create User Login ${e.toString()}');
      emit(LoginFailureState(
          errorMessage:
              'error happened when create User Login ${e.toString()}'));
    }
  }
}
