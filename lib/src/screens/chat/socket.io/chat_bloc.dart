// import 'dart:async';
// import 'dart:io';
// import 'package:adhara_socket_io/manager.dart';
// import 'package:adhara_socket_io/options.dart';
// import 'package:adhara_socket_io/socket.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:rentstation/App/app_event.dart';
// import 'package:rentstation/App/app_state.dart';
// import 'package:rentstation/Components/custom_progress_dialog.dart';
// import 'package:rentstation/Repository/appLocalization.dart';
// import 'package:rentstation/helpers/date_helper.dart';
// import 'package:rentstation/helpers/sharedPref_helper.dart';
// import 'package:rentstation/models/msg_model.dart';
// import 'package:rentstation/models/photo_model.dart';
// import 'package:provider/provider.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:t3myrkm/src/logic/providers/general/shared_preferences_provider.dart';

// import 'apiProvider.dart';
// class ChatBloc extends Bloc<AppEvent, AppState> {
//   final _api = ApiProvider();
//   final _context = BehaviorSubject<BuildContext>();
//   final _msg = BehaviorSubject<String>();
//   final _chatID = BehaviorSubject<int>();
//   final _secondUserID = BehaviorSubject<int>();
//   final _photo = BehaviorSubject<File>();
//   final _photoLink = BehaviorSubject<String>();
//   final _lat = BehaviorSubject<String>();
//   final _long = BehaviorSubject<String>();
//   final _messagesController = PublishSubject<MsgModel>();
//   final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();
//   SocketIO _socket;
//   SocketIOManager _manager = SocketIOManager();
//   String _ring;
//   AudioPlayer audioPlayer = AudioPlayer();
//   ChatBloc() : super(null);
//   Function(String) get updateMsg => _msg.sink.add;
//   Function(BuildContext) get updateContext => _context.sink.add;

//   Function(String) get updatePhotoLink => _photoLink.sink.add;

//   Function(String) get updateLat => _lat.sink.add;

//   Function(String) get updateLong => _long.sink.add;

//   Function(int) get updateChatID => _chatID.sink.add;

//   Function(int) get updateSecondUserID => _secondUserID.sink.add;

//   Function(File) get updatePhoto => _photo.sink.add;

//   Function(MsgModel) get addMessage => _messagesController.sink.add;

//   Stream<MsgModel> get messages =>
//       _messagesController.stream.asBroadcastStream();

//   Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;
//   CustomProgressDialog customProgressDialog;
//   ProgressDialog pr;
//   dispose() {
//     _key.close();
//     _msg.close();
//     _photoLink.close();
//     _lat.close();
//     _long.close();
//     _chatID.close();
//     _secondUserID.close();
//     _msg.close();
//     _photo.close();
//     _messagesController.close();
//     _messagesController.close();
//     _context.close();
//   }

//   clear() {
//     _photo.value = null;
//     _chatID.value = null;
//     _photoLink.value = null;
//     _lat.value = null;
//     _long.value = null;
//     _msg.value = null;
//     _manager.clearInstance(_socket);
//   }

//   clearMsg() {
//     _photo.value = null;
//     _photoLink.value = null;
//     _lat.value = null;
//     _long.value = null;
//     _msg.value = null;
//   }

//   @override
//   AppState get initialState => Start();

//   @override
//   Stream<AppState> mapEventToState(AppEvent event) async* {
//     // if (event is Restart) {
//     //   yield Start();
//     // }
//     if (event is UploadPhoto) {
//       if (_photo.value != null) {
//         PhotoModel _res =
//             await _api.uploadPhoto(photo: _photo.value).catchError((e) {
//           _key.value.currentState.showSnackBar(
//               SnackBar(content: Text(localization.text('internet'))));
//         });
//         if (_res.code == 200) {
//           updatePhotoLink(_res.data);
//         }
//       }
//     }
//     if (event is Init) {
//       customProgressDialog =
//           CustomProgressDialog(context: _context.value, pr: pr);
//       customProgressDialog.showProgressDialog();
//       customProgressDialog.showPr();
//       PhotoModel _voice = await _api.getVoiceRing().catchError((e) {
//         _key.value.currentState.showSnackBar(
//             SnackBar(content: Text(localization.text('internet'))));
//       });
//       if (_voice.code == 200) {
//         _ring = _voice.data;
//       }
//       // sharedBloc.add(Click());
//       var _old = await _api.getMessages(
//           chatID: _chatID.value,
//           token: Provider.of<SharedPref>(_context.value, listen: false).token);

//       if (_old.code == 200) {
//         Future.delayed(Duration(seconds: 1), () {
//           customProgressDialog.hidePr();
//         });
//         for (int i = 0; i < _old.data.length; i++) {
//           if (_old.data[i].message != null ||
//               _old.data[i].file != null ||
//               _old.data[i].latitude != null ||
//               _old.data[i].longitude != null) {
//             addMessage(_old.data[i]);
//           }
//         }
//       } else {
//         Future.delayed(Duration(seconds: 1), () {
//           customProgressDialog.hidePr();
//         });
//       }
//       print('>>> Start init');
//       _socket = await _manager.createInstance(
//         SocketOptions("https://electronic-ar.net:2023",
//             query: {
//               "room_id": "${_chatID.value}",
//             },
//             enableLogging: true,
//             transports: [
//               Transports.WEB_SOCKET,
//               Transports.POLLING,
//             ] //Enable required transport
//             ),
//       );
//       socketIO.emit('user-connected', [
//         {
//           "room_id": _chatID.value.toString(),
//           "api_token":
//               Provider.of<SharedPref>(_context.value, listen: false).token
//         }
//       ]);
//       socketIO.onConnect((connection) {
//         print('<<< Socket connected >>>');
//         socketIO.on('chat message', (data) async {
//           if (_chatID.value.toString() == data["room_id"] &&
//               Provider.of<SharedPref>(_context.value, listen: false).id !=
//                   data["user_id"]) {
//             print('<<< Receive Msg >>> ${data.toString()}');
//             MsgModel _msg = new MsgModel(
//                 message: data["msg"],
//                 userPhoto: data["img"],
//                 createdAt: TextHelper().formatDateTime(date: DateTime.now()),
//                 userId: data["user_id"],
//                 file: data["file"]);
//             await audioPlayer.play(_ring);
//             addMessage(_msg);
//             // _msg = null;
//           }
//         });
//       });
//       socketIO.connect();
//     }
//     if (event is SendMsg) {
//       MsgModel _newMsg = new MsgModel(
//           message: _msg.value,
//           userId: Provider.of<SharedPref>(_context.value, listen: false).id,
//           secondUserId: _chatID.value,
//           token: Provider.of<SharedPref>(_context.value, listen: false).token,
//           createdAt: TextHelper().formatDateTime(date: DateTime.now()),
//           file: _photoLink.value,
//           userPhoto:
//               Provider.of<SharedPref>(_context.value, listen: false).photo,
//           roomID: _chatID.value.toString());
//       print(
//           "token ${Provider.of<SharedPref>(_context.value, listen: false).token}");
//       print("room id ${_chatID.value.toString()}");
//       socketIO.emit("send-message", [
//         {
//           "api_token":
//               Provider.of<SharedPref>(_context.value, listen: false).token,
//           "room_id": _chatID.value.toString(),
//           "file": _photoLink.value,
//           "message": _msg.value,
//           "lang": "ar",
//           "file_type": "text",
//           "countryId": "178",
//           "duration": 1
//         }
//       ]);
//       socketIO.emit('chat message', [
//         {
//           "msg": _msg.value,
//           "room_id": _chatID.value.toString(),
//           "img": Provider.of<SharedPreferencesProvider>(_context.value, listen: false).prefs.get('image'),
//           "file": _photoLink.value,
//           "user_id": Provider.of<SharedPreferencesProvider>(_context.value, listen: false).prefs.get('key'),
//         }
//       ]);
//       clearMsg();
//       addMessage(_newMsg);
//       // _newMsg = null;
//     }
//   }
// }

// final chatBloc = ChatBloc();

// import 'dart:io';
// export 'dart:ui';
// import 'package:adhara_socket_io/adhara_socket_io.dart';

// Socket socket;
// SocketIO socketIO;
// SocketIOManager manager;

// void main() async {
//   manager = SocketIOManager();
//   socketIO = await manager.createInstance(
//     SocketOptions(
//       'https://tameercom.tqnee.com:1900',
//       enableLogging: true,
//       query: {
//         'room_id': '3',
//       },
//     ),
//   );
//   socketIO.connect();
//   // Socket.connect('https://tameercom.tqnee.com', 1900).then((Socket sock) {
//   //   socket = sock;
//   //   socket.listen(dataHandler,
//   //       onError: errorHandler, onDone: doneHandler, cancelOnError: false);
//   // }).catchError((e) {
//   //   print("Unable to connect: ${e}");
//   // });
//   // //Connect standard in to the socket
//   // stdin.listen(
//   //     (data) => socket.write(new String.fromCharCodes(data).trim() + '\n'));
// }

// // void dataHandler(data) {
// //   print(new String.fromCharCodes(data).trim());
// // }

// // void errorHandler(error, StackTrace trace) {
// //   print(error);
// // }

// // void doneHandler() {
// //   socket.destroy();
// // }

// setOnConnectListener(Function onConnect) {
//   socketIO.onConnect((data) {
//     print('connect $data');

//     onConnect(data);
//   });
// }

// setOnConnectErrorTimeOutListener(Function onConnectErrorTimeout) {
//   socketIO.onConnectTimeout((data) {
//     print('connect error timeout $data');

//     onConnectErrorTimeout(data);
//   });
// }

// setOnConnectErrorListener(Function onConnectError) {
//   socketIO.onConnectError((data) {
//     print('connect error $data');
//     onConnectError(data);
//   });
// }

// setOnErrorListener(Function onError) {
//   socketIO.onError((data) {
//     print('error $data');

//     onError(data);
//   });
// }

// setDisconnectListener(Function onDisconnectError) {
//   socketIO.onDisconnect((data) {
//     print('disconnect $data');

//     onDisconnectError(data);
//   });
// }
