

class ChatMessageModel {
  int conversationId;
  int senderId;
  String chatFile;
  String message;
  String senderImage;
  String senderName;
  String apiToken;
  ChatMessageModel({
    this.conversationId,
    this.chatFile,
    this.message,
    this.senderId,
    this.apiToken,
    this.senderName,
    this.senderImage,
  });

  Map<String, dynamic> toJson(bool isEvent) => {
        'room_id': conversationId == null ? null : conversationId,
        'file': chatFile == null ? null : chatFile,
        'message': message == null ? null : message,
        'user_id': senderId == null ? null : senderId,
        'sender_id': senderId == null ? null : senderId,
        "api_token": apiToken,
        "name": senderName,
        'img': senderImage,
        "created_at": DateTime.now().toString(),
        "file_type": "text",
      };
  // : {
  //     'room_id': conversationId == null ? null : conversationId,
  //     'file': chatFile == null ? null : chatFile,
  //     'message': message == null ? null : message,
  //     'user_id': senderId == null ? null : senderId,
  //     "api_token": apiToken,
  //     "file_type": "text",
  //   };
}
