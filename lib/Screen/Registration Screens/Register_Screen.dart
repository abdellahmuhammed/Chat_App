import 'package:chat_app3/Screen/Registration%20Screens/Login_Screen.dart';
import 'package:chat_app3/cubits/RegisterCubit/register_cubit.dart';
import 'package:chat_app3/shared/components.dart';
import 'package:chat_app3/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Home_Screen.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userEmail, userPassword;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterIsLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(userEmail: userEmail),
            ),
          );
          //navigateAndRemove(context, HomeScreen(userEmail: userEmail));
          snackBarErrorMassage(context, message: 'Register Successfully');
          isLoading = false;
        } else if (state is RegisterFailureState) {
          snackBarErrorMassage(context, message: state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                      MaterialButton(
                        minWidth: double.infinity,
                        color: kButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await BlocProvider.of<RegisterCubit>(context)
                                .userRegister(
                              context,
                              userEmail: userEmail!,
                              userPassword: userPassword!,
                            );
                          }
                        },
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
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
            ),
          ),
        );
      },
    );
  }
}
