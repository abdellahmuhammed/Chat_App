import 'package:chat_app3/Screen/Home_Screen.dart';
import 'package:chat_app3/Screen/Registration%20Screens/Register_Screen.dart';
import 'package:chat_app3/cubits/loginCubit/login_cubit.dart';
import 'package:chat_app3/shared/components.dart';
import 'package:chat_app3/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? userEmail, userPassword;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginIsLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          navigateAndRemove(context, HomeScreen(userEmail: userEmail));
          snackBarErrorMassage(context, message: 'Login Successfully');
          isLoading = false;
        } else if (state is LoginFailureState) {
          snackBarErrorMassage(context, message: state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: CustomAppBar(context),
          body: Form(
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
                    const SizedBox(height: 10),
                    Text(
                      'Login '.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      onChanged: (password) {
                        userPassword = password;
                      },
                      label: 'Enter your password',
                      formKey: formKey,
                      prefixIcon: Icons.lock,
                      passwordSecure: true,
                      keyboardType: TextInputType.text,
                      stringValidate: 'Password was Missed',
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      minWidth: double.infinity,
                      color: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).userLogin(
                              context,
                              userEmail: userEmail,
                              userPassword: userPassword);
                        }
                      },
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Do not have an account?',
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
          ),
        ),
      ),
    );
  }
}
