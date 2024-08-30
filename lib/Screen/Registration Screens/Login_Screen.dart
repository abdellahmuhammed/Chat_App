import 'package:chat_app3/Screen/Home_Screen.dart';
import 'package:chat_app3/Screen/Registration%20Screens/Register_Screen.dart';
import 'package:chat_app3/shared/components.dart';
import 'package:chat_app3/shared/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userEmail, userPassword;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: CustomAppBar(context),
        body: bodyLoginScreen(context),
      ),
    );
  }

// build Body of
  Form bodyLoginScreen(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/chat_Image.png',
                height: MediaQuery.of(context).size.height * .40,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Login '.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              // Email Text Form Field
              CustomTextFormField(
                onChanged: (email) {
                  userEmail = email;
                },
                label: 'Enter your Email',
                formKey: formKey,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                stringValidate: 'Email was Missed',
              ),
              const SizedBox(
                height: 30,
              ),
              //password Text Form Field
              CustomTextFormField(
                onChanged: (password) {
                  userPassword = password;
                },
                label: 'Enter your password',
                formKey: formKey,
                prefixIcon: Icons.lock,
                passwordSecure: true,
                suffixIcon: Icons.visibility,
                keyboardType: TextInputType.text,
                stringValidate: ' Password was Missed',
              ),
              const SizedBox(
                height: 20,
              ),
              LoginMaterialButton(context),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Do not have account ?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomGestureDetector(
                    text: '  Register',
                    widget: RegisterScreen(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  LoginMaterialButton(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      color: kButtonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          try {
            isLoading = true;
            setState(() {});
            await buildUserLogin();
            snackBarErrorMassage(context, message: 'login Successfully');
            navigateAndRemove(context, HomeScreen(userEmail: userEmail!,));
            isLoading = false;
            setState(() {});
          } on FirebaseAuthException catch (e) {
            buildErrorLogin(e, context);
            isLoading = false;
            setState(() {});
          } catch (e) {
            snackBarErrorMassage(context,
                message: 'an error happened try again');

            print('error happened ${e.toString()}');
          }
        }
      },
      child: Text(
        'Login',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Future<void> buildUserLogin() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail!, password: userPassword!);
  }

  void buildErrorLogin(FirebaseAuthException e, BuildContext context) {
    if (e.code == 'user-not-found') {
      snackBarErrorMassage(context, message: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('error is in password${e.toString()}');
      snackBarErrorMassage(context,
          message: 'Wrong password provided for that user');
    }else{
         snackBarErrorMassage(context,
          message: 'email or password was Wrong');
    }
  }
}
