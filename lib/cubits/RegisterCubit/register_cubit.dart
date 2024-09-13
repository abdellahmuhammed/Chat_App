import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> userRegister(
    context, {
    required String userEmail,
    required String userPassword,
  }) async {
    emit(RegisterIsLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      debugPrint('create User Register Successfully');
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        emit(RegisterFailureState(
            errorMessage: 'The account already exists for that email'));
      }
      // التحقق من أن البريد الإلكتروني يحتوي على @ وعلى نطاق صحيح
      else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(userEmail)) {
        emit(RegisterFailureState(errorMessage: 'Invalid email format'));
      }
      else if (e.code == 'weak-password'){
        emit(RegisterFailureState(
            errorMessage: 'The password provided is too weak'));
      }
      // التحقق من أن كلمة السر تحتوي على أحرف وأرقام
      else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(userPassword)){
        emit(RegisterFailureState(errorMessage: 'Password must contain letters and numbers'));
      }
    } on Exception catch (e) {
      debugPrint(
          'error happened when create User Register Method ${e.toString()}');
      emit(
          RegisterFailureState(errorMessage: 'error happened ${e.toString()}'));
    }
  }
}
