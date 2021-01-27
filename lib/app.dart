import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/screens/screens.dart';
import 'package:regimental_app/services/push_notification_service.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class App extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final VemRepository vemRepository;
  final VemResponseRepository vemResponseRepository;

  @override
  _AppState createState() => _AppState();

  const App(
      {Key key,
      @required this.authenticationRepository,
      @required this.vemRepository,
      @required this.vemResponseRepository,
      @required this.userRepository})
      : super(key: key);
}

class _AppState extends State<App> {
  final PushNotificationService pushNotificationService =
      PushNotificationService();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    super.initState();

    handleNotifications();
  }

  Future<void> handleNotifications() async {
    pushNotificationService.initialize();

    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    try {
      if (initialMessage?.data['type'] == 'new_vem' ||
          initialMessage?.data['type'] == 'vem_reminder') {
        Navigator.pushNamed(
          context,
          VemDetailsScreen.routeName,
          arguments: VemDetailsScreenArguments(
            vemId: initialMessage?.data['vemId'],
          ),
        );
      } else if (initialMessage?.data['type'] == 'response_change_status') {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } catch (exception) {
      print('no such methoOOOOOOOOOOd');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['type'] == 'new_vem' ||
          message.data['type'] == 'vem_reminder') {
        Navigator.pushNamed(
          context,
          VemDetailsScreen.routeName,
          arguments: VemDetailsScreenArguments(
            vemId: initialMessage?.data['vemId'],
          ),
        );
      } else if (message?.data['type'] == 'response_change_status') {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: widget.authenticationRepository,
            ),
          ),
          BlocProvider<UsersBloc>(
            create: (context) =>
                UsersBloc(userRepository: widget.userRepository)
                  ..add(LoadCurrentUser()),
          ),
          BlocProvider<UserResponsesBloc>(
            create: (context) => UserResponsesBloc(
                vemResponseRepository: widget.vemResponseRepository)
              ..add(
                LoadResponsesForUser(FirebaseAuth.instance.currentUser.uid),
              ),
          ),
          BlocProvider<VemResponsesBloc>(
            create: (context) => VemResponsesBloc(
              vemResponseRepository: widget.vemResponseRepository,
            ),
          ),
          BlocProvider<VemsBloc>(
            create: (context) => VemsBloc(vemRepository: widget.vemRepository)
              ..add(LoadVemListData()),
          ),
        ],
        child: Consumer<ThemeNotifier>(builder: (context, theme, _) {
          return MaterialApp(
            theme: theme.getTheme(),
            navigatorKey: _navigatorKey,
            routes: {
              HomeScreen.routeName: (context) => HomeScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
              AddEditVemScreen.routeName: (context) => AddEditVemScreen(),
              VemDetailsScreen.routeName: (context) => VemDetailsScreen(),
              ProfileScreen.routeName: (context) => ProfileScreen(
                    selectedIndex: 2,
                  ),
            },
            builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        HomeScreen.route(),
                        (route) => false,
                      );
                      break;
                    case AuthenticationStatus.unauthenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        LoginScreen.route(),
                        (route) => false,
                      );
                      break;
                    default:
                      break;
                  }
                },
                child: child,
              );
            },
            onGenerateRoute: (_) => SplashScreen.route(),
          );
        }),
      ),
    );
  }
}
