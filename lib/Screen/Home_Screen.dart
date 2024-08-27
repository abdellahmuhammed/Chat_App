import 'package:chat_app3/shared/components.dart';
import 'package:chat_app3/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: messages.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
         
          return Container(
              color: kButtonColor,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        } else if (snapshot.hasData) {
           print(snapshot.data!.docs[0]['messages']);
          return Scaffold(
            
            appBar: CustomAppBar(context,
                tittle: 'Samona Chat', centerTittle: true),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => CustomChatContainer(
                      bottomRight: 5,
                      color: kPrimaryColor,
                      text: 'new gona lsjdfddkdg',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: controller,
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
                      suffixIcon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      label: Text('Send Message'),
                      labelStyle: TextStyle(color: kPrimaryColor),
                    ),
                    onSubmitted: (message) {
                      if (message.isNotEmpty) {
                        messages.add({'messages': message});
                        controller.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('error happened');
        }
      },
    );
  }
}
