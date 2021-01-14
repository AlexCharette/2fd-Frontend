part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class Idle extends NotificationState {}

class NotificationReceived extends NotificationState {
  final Notification notification;

  const NotificationReceived([this.notification]);

  @override
  List<Object> get props => [notification];

  @override
  String toString() =>
      'NotificationReceived { notificationReceived: $notification }';
}
