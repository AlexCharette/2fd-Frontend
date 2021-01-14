import 'dart:async';
import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import '../models/models.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirebaseMessaging _firebaseMessaging;
  final _localNotifications = new FlutterLocalNotificationsPlugin();
  String _token;

  NotificationBloc({@required firebaseMessaging})
      : assert(firebaseMessaging != null),
        _firebaseMessaging = firebaseMessaging,
        super(Idle());

  Future initialize() async {
    NotificationAppLaunchDetails _appLaunchDetails =
        await _localNotifications.getNotificationAppLaunchDetails();

    // TODO are these needed?
    final BehaviorSubject<Notification> didReceiveLocalNotificationSubject =
        BehaviorSubject<Notification>();

    final BehaviorSubject<String> selectNotificationSubject =
        BehaviorSubject<String>();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(
            Notification(id: id, title: title, body: body, payload: payload));
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload);
    });

    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    try {
      _token = await _firebaseMessaging.getToken();

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
    } catch (error) {
      add(NotificationError(error.toString()));
    }
  }

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is NewNotification) {
      yield* _mapNewNotificationToState(event);
    } else if (event is NotificationError) {
      yield* _mapNotificationErrorToState(event);
    }
  }

  Stream<NotificationState> _mapNewNotificationToState(
      NewNotification event) async* {
    // TODO
  }

  Stream<NotificationState> _mapNotificationErrorToState(
      NotificationError event) async* {
    // TODO
  }
}
