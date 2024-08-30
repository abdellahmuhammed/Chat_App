import 'package:chat_app3/shared/constant.dart';

class MessageModel {
  final String message;
  final String id;
  final DateTime date;
  MessageModel(this.message, this.id, this.date);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      jsonData[kMessage],
      jsonData['id'],
      DateTime.parse(jsonData[kCreatedAt])
    );
  }
}
