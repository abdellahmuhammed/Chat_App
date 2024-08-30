import 'package:chat_app3/Screen/Registration%20Screens/Login_Screen.dart';
import 'package:chat_app3/model/MessageModel.dart';
import 'package:chat_app3/shared/components.dart';
import 'package:chat_app3/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.userEmail});
  final String userEmail;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);

  final TextEditingController txetFormController = TextEditingController();
  final lsitController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return _buildHomeScreen();
  }

  Scaffold _buildHomeScreen() {
    return Scaffold(
      appBar: CustomAppBar(context, tittle: 'Samona Chat', centerTittle: true),
      body: StreamBuilder(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildDataLoading();
          } else if (snapshot.hasData) {
            return _buildDataConected(snapshot, context);
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }

  _buildDataConected(
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
              controller: lsitController,
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
          child: CustomTextFild(
              txetFormController: txetFormController,
              messages: messages,
              widget: widget,
              lsitController: lsitController),
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

class CustomTextFild extends StatelessWidget {
  const CustomTextFild({
    super.key,
    required this.txetFormController,
    required this.messages,
    required this.widget,
    required this.lsitController,
  });

  final TextEditingController txetFormController;
  final CollectionReference<Object?> messages;
  final HomeScreen widget;
  final ScrollController lsitController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: txetFormController,
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
            if (txetFormController.text.isNotEmpty) {
              messages.add({
                kMessage: txetFormController.text,
                kCreatedAt: DateTime.now(),
                'id': widget.userEmail
              });
              txetFormController.clear();
              lsitController.animateTo(
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
