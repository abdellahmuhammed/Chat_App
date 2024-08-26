import 'package:chat_app3/Screen/Home_Screen.dart';
import 'package:chat_app3/Screen/Registration%20Screens/Login_Screen.dart';
import 'package:chat_app3/shared/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userEmail, userPassword;
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: CustomAppBar(context),
        body: bodyRegisterScreen(context),
      ),
    );
  }
// build Body of
  Form bodyRegisterScreen(BuildContext context) {
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
                'Register '.toUpperCase(),
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
                controller: passwordController,
                onChanged: (password) {
                  userPassword = password;
                },
                label: 'Enter your password',
                formKey: formKey,
                prefixIcon: Icons.lock,
                passwordSecure: false,
                suffixIcon: Icons.visibility,
                keyboardType: TextInputType.text,
                stringValidate: ' Password was Missed ',
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterMaterialButton(context),
              //CustomRegisterMaterialButton(formKey: formKey, userEmail: userEmail , userPassword: userPassword,),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'already have an account?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomGestureDetector(
                    text: '  Login',
                    widget: LoginScreen(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  RegisterMaterialButton(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      color: Colors.blueAccent.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          try {
            // التحقق من أن البريد الإلكتروني يحتوي على @ وعلى نطاق صحيح
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(userEmail!)) {
              snackBarErrorMassage(context, message: 'Invalid email format');
            }
            // التحقق من طول البريد الإلكتروني
            else if (userEmail!.length < 5) {
              snackBarErrorMassage(context, message: 'Email is too short');
            }
            // التحقق من أن كلمة السر تحتوي على أحرف وأرقام
            if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(userPassword!)) {
              snackBarErrorMassage(context, message: 'Password must contain letters and numbers');
              return;
            }

            isLoading = true;
            setState(() {});
            await buildUserRegister();
            snackBarErrorMassage(context,
                message: 'Register Successfully');
            navigateAndRemove(context, HomeScreen());
            isLoading = false;
            setState(() {});
          } on FirebaseAuthException catch (e) {
            buildErrorRegister(e, context);
            isLoading = false;
            setState(() {});
          } catch (e) {
            snackBarErrorMassage(context,
                message: 'an error happened try again');
            print('error happened ${e.toString()}');
            isLoading = false;
            setState(() {});
          }
        }
      },
      child: Text(
        'Register',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Future<void> buildUserRegister() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userEmail!, password: userPassword!);
  }
  void buildErrorRegister(FirebaseAuthException e, BuildContext context) {
    if (e.code == 'weak-password') {
      snackBarErrorMassage(context, message: 'The password provided is too weak');
      print('The password provided is too weak.');
    }
    else if (e.code == 'email-already-in-use') {
      snackBarErrorMassage(context, message: 'The account already exists for that email');
      print('The account already exists for that email.');
    }
    else{
      snackBarErrorMassage(context, message: 'happened error try again');
      print('happened error try again.');
    }
  }
}
