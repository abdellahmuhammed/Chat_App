import 'package:chat_app3/shared/constant.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id,);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      jsonData[kMessage],
      jsonData['id'],
    );
  }
}
