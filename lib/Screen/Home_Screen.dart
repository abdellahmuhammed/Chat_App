import 'package:chat_app3/Screen/Registration%20Screens/Login_Screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()),
            );
          }, icon:Icon(Icons.add))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Home Screen ' , style:  Theme.of(context).textTheme.titleLarge,),
          )
        ],
      ),
    );
  }
}
