
import 'package:adhara_socket_io/socket.dart';
import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../logic/models/chat/chat_message_model.dart';
import '../../../logic/providers/general/shared_preferences_provider.dart';

class SocketUtils {


  SocketIO _socket;
  SocketIOManager _manager;
  int conversationId;
  bool _sendOnline = true;
  initSocket(int conversationId, BuildContext context) async {
    this.conversationId = conversationId;
    print('con $conversationId');
    _manager = SocketIOManager();
    _socket = await _manager.createInstance(
      SocketOptions(
        'https://tameercom.tqnee.com:1900',
        enableLogging: true,
        transports: [
          Transports.WEB_SOCKET,
          Transports.POLLING,
        ],
        query: {
          "room_id": conversationId.toString(),
        },
      ),
    );
    print(
        '${Provider.of<SharedPreferencesProvider>(context, listen: false).prefs.get('token')} room_id:$conversationId');

    connectToSocket();
    _socket.emit('user-connected', [
      {
        "room_id": '$conversationId',
        "api_token":
            Provider.of<SharedPreferencesProvider>(context, listen: false)
                .prefs
                .get('token'),
      }
    ]);
  }



  connectToSocket() {
    if (_socket == null) {
      return;
    }
    _socket.connect();
  }

  setOnConnectListener(Function onConnect) {
    _socket.onConnect((data) {
      print('connect $data');

      onConnect(data);
    });
  }

  setOnConnectErrorTimeOutListener(Function onConnectErrorTimeout) {
    _socket.onConnectTimeout((data) {
      print('connect error timeout $data');

      onConnectErrorTimeout(data);
    });
  }

  setOnConnectErrorListener(Function onConnectError) {
    _socket.onConnectError((data) {
      print('connect error $data');
      onConnectError(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.onError((data) {
      print('error $data');

      onError(data);
    });
  }

  setDisconnectListener(Function onDisconnectError) {
    _socket.onDisconnect((data) {
      print('disconnect $data');

      onDisconnectError(data);
    });
  }

  closeConnection() {
    if (null != _socket) {
      print('connection closed');
      _manager.clearInstance(_socket);
    }
  }

  onUserTyping(BuildContext context, Function onUserTyping) {
    print('type');
    _socket.emit(
      'typing',
      [
        {
          'api_token':
              Provider.of<SharedPreferencesProvider>(context, listen: false)
                  .prefs
                  .get('token'),
        },
      ],
    );
  }

  onUserTypingListener(Function onUserTyping) {
    print('type');

    _socket.on('typing', (data) {
      onUserTyping(data);
    });
  }

  onUserStopTypingListener(Function onUserStopped) {
    print('stopped');

    _socket.on('stop_typing', (data) {
      onUserStopped(data);
    });
  }

  onUserStopTyping(BuildContext context, Function onUserStopped) {
    print('stopped');
    _socket.emit(
      'stop_typing',
      [
        {
          'api_token':
              Provider.of<SharedPreferencesProvider>(context, listen: false)
                  .prefs
                  .get('token'),
        },
      ],
    );
  }

  sendMessage(
    ChatMessageModel messageModel,
  ) {
    // print('kkk');
    if (_socket != null) {
      _socket.emit(
        'send-message',
        [
          messageModel.toJson(false),
        ],
      );
      _socket.emit('chat message', [
        messageModel.toJson(true),
      ]);
    }
  }

  userConnect(Function userConnectedListener, BuildContext context) {
    _socket.on('user-connected', (data) {
      userConnectedListener(data);
      if ((data as Map).isNotEmpty &&
          data['api_token'] !=
              Provider.of<SharedPreferencesProvider>(context, listen: false)
                  .prefs
                  .get('token') &&
          _sendOnline) {
        _socket.emit('user-connected', [
          {
            "room_id": '$conversationId',
            "api_token":
                Provider.of<SharedPreferencesProvider>(context, listen: false)
                    .prefs
                    .get('token'),
          }
        ]);
        _sendOnline = false;
      }
    });
  }

  userDisconnect(Function userDisconnectedListener) {
    _socket.on('disconnect', (data) {
      print('disconned $data');
      userDisconnectedListener(data);
    });
  }

  receiveMessage(Function onMessageRecieved) {
    _socket.on('chat message', (data) {
      print('chat Messsage: $data');
      onMessageRecieved(data);
    });
    _socket.on('send-message', (data) {
      print('chatMesssage: $data');
      // onMessageRecieved(data);
    });
  }
}
