import 'package:chat_app3/shared/constant.dart';

class MessageModel {
  final String message;

  MessageModel( this.message);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData[kMessage]);
  }

}
