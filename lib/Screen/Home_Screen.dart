import 'package:chat_app3/Screen/Registration%20Screens/Login_Screen.dart';
import 'package:chat_app3/model/MessageModel.dart';
import 'package:chat_app3/shared/components.dart';
import 'package:chat_app3/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.userEmail});
  final String? userEmail;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);

  final TextEditingController textFormController = TextEditingController();
  final listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return _buildHomeScreen();
  }

  Scaffold _buildHomeScreen() {
    return Scaffold(
      appBar: CustomAppBar(context, tittle: 'Chat App', centerTittle: true),
      body: StreamBuilder(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildDataLoading();
          } else if (snapshot.hasData) {
            return _buildDataConnected(snapshot, context);
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }

  _buildDataConnected(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    List<MessageModel> messageList = [];
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      messageList.add(
        MessageModel.fromJson(snapshot.data!.docs[i]),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              reverse: true,
              controller: listController,
              itemCount: messageList.length,
              itemBuilder: (context, index) {
                return messageList[index].id == widget.userEmail
                    ? CustomChatContainer(
                        alignment: Alignment.centerLeft,
                        bottomRight: 5,
                        color: kPrimaryColor,
                        message: messageList[index],
                      )
                    : CustomChatContainer(
                        alignment: Alignment.centerRight,
                        color: Colors.blueGrey[50]!,
                        message: messageList[index],
                        bottomLeft: 15,
                      );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomTextFiled(
              textFormController: textFormController,
              messages: messages,
              widget: widget,
              listController: listController),
        ),
      ],
    );
  }
}

Center _buildDataLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    required this.textFormController,
    required this.messages,
    required this.widget,
    required this.listController,
  });

  final TextEditingController textFormController;
  final CollectionReference<Object?> messages;
  final HomeScreen widget;
  final ScrollController listController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFormController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            if (textFormController.text.isNotEmpty) {
              messages.add({
                kMessage: textFormController.text,
                kCreatedAt: DateTime.now(),
                'id': widget.userEmail
              });
              textFormController.clear();
              listController.animateTo(
                0,
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
              );
            }
          },
          icon: Icon(
            Icons.send,
            color: kPrimaryColor,
          ),
        ),
        label: Text('Send Message'),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
    );
  }
}
