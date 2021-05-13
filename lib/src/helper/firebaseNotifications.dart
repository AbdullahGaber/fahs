import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../screens/mainScreens/splash_screen.dart';
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async{
  print('on background $message');
}

class FirebaseNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging _firebaseMessaging;
  GlobalKey<NavigatorState> navigatorKey;

  BuildContext context;

  void setUpFirebase(
      GlobalKey<NavigatorState> navigatorKey, BuildContext context) {
    this.context = context;
    this.navigatorKey = navigatorKey;

    print('hi');
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners();
  }

  // ignore: non_constant_identifier_names
  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("TOOOKEN" + token);
    });

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('myMessage : $message');
          print('on message ' + message['data'].toString() + 'ads');

        
        
         
        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          handlePath(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
          handlePath(message);
        },
        onBackgroundMessage: myBackgroundMessageHandler);
  }

  // ignore: non_constant_identifier_names
  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void handlePath(Map<String, dynamic> dataMap) {
    handlePathByRoute(dataMap);
  }

  void handlePathByRoute(Map<String, dynamic> dataMap) {
    navigatorKey.currentState
        .push(MaterialPageRoute(builder: (context) => Splash()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  // ignore: missing_return
  Future onSelectNotification(String payload) {}

  static StreamController<Map<String, dynamic>> _onMessageStreamController =
      StreamController.broadcast();

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void killNotification() {
    _onMessageStreamController.close();
  }
}
