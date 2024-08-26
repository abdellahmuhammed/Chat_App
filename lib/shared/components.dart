import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String label;
  final TextEditingController? controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool? passwordSecure;
  final String stringValidate;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  CustomTextFormField(
      {super.key,
      required this.formKey,
      required this.label,
      required this.prefixIcon,
      this.stringValidate = 'some info is missed',
      this.suffixIcon,
      this.controller,
      this.passwordSecure = false,
      this.keyboardType,
      this.onChanged,
      });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: passwordSecure!,
      decoration: InputDecoration(
        label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(suffixIcon),
        ),
      ),
      // onFieldSubmitted: (value) {
      //   if (formKey.currentState!.validate()) {
      //     navigateTo(context, widget);
      //   }
      // },
      validator: (String? value) {
        if (value == null || value == false || value.isEmpty) {
          return stringValidate;
        }
        return null;
      },
    );
  }
}




// Custom Material Button To Send Data from Login screen to Home screen or from Register Screen to home screen
// class CustomMaterialButton extends StatelessWidget {
//   final GlobalKey<FormState> formKey;
//
//   final String text;
//   final Widget widget;
//   final Color color;
//   final double minWidth;
//
//   CustomMaterialButton({
//     super.key,
//     required this.formKey,
//     required this.text,
//     required this.widget,
//     this.color = Colors.blueAccent,
//     this.minWidth = double.infinity,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       minWidth: minWidth,
//       color: color,
//       onPressed: () {
//         if (formKey.currentState!.validate()) {
//           return navigateAndRemove(context, widget);
//         }
//       },
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.titleLarge,
//       ),
//     );
//   }
// }

/*
// // Custom Material Button To navigate from Login screen to Register Screen or reverse( Register Screen to  Login screen)
// class CustomMaterialButtonToNavigateScreen extends StatelessWidget {
//   const CustomMaterialButtonToNavigateScreen({
//     super.key,
//     required this.text,
//     required this.widget,
//   });
//
//   final String text;
//   final Widget widget;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       padding: EdgeInsets.zero,
//       onPressed: () {
//         navigateTo(context, widget);
//       },
//       child: Text(
//         text,
//         style: Theme.of(context).textTheme.titleLarge,
//       ),
//     );
//   }
// }

// Custom Custom Gesture Detector To navigate from Login screen to Register Screen or reverse( Register Screen to  Login screen)
*/

// Custom Custom Gesture Detector To navigate from Login screen to Register Screen or Reverse( Register Screen to  Login screen)

class CustomGestureDetector extends StatelessWidget {
  const CustomGestureDetector({
    super.key,
    required this.text,
    required this.widget,
  });

  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateAndRemove(context, widget);
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

AppBar CustomAppBar(context,
        {String text = 'Chat App', bool automaticallyImplyLeading = false}) =>
    AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );

void snackBarErrorMassage(context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue,
      content: Text(textAlign: TextAlign.center, message),
    ),
  );
}

void navigateAndRemove(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}