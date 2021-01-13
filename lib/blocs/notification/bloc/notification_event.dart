part of 'notification_bloc.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NewNotification extends NotificationEvent {
  final Notification notification;

  const NewNotification([this.notification]);

  @override
  List<Object> get props => [notification];

  @override
  String toString() => 'NewNotification { newNotification: $notification }';
}

class NotificationError extends NotificationEvent {
  final String error;

  const NotificationError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'NotificationError { notificationError: $error }';
}

class NavigateToView extends NotificationEvent {
  final String route;

  const NavigateToView(this.route);

  @override
  List<Object> get props => [route];

  @override
  String toString() => 'NavigateToView { navigateToView: $route }';
}

class SubmitResponse extends NotificationEvent {
  final String response;

  const SubmitResponse(this.response);

  @override
  List<Object> get props => [response];

  @override
  String toString() => 'SubmitResponse { submitResponse: $response }';
}
