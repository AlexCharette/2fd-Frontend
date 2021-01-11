import 'package:authentication_repository/authentication_repository.dart';
import 'package:regimental_app/blocs/users/bloc/users_bloc.dart';
import 'package:regimental_app/screens/profile/profile.dart';
import 'package:regimental_app/screens/reset_password/view/reset_password_screen.dart';
import 'package:regimental_app/screens/vem_details/view/view.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/screens/add_edit_vem/add_edit_vem.dart';
import 'package:regimental_app/screens/home/home.dart';
import 'package:regimental_app/screens/login/login.dart';
import 'package:regimental_app/screens/splash/splash.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.vemRepository,
    @required this.vemResponseRepository,
    @required this.userRepository
  })  : assert(authenticationRepository != null),
        assert(vemRepository != null),
        assert(vemResponseRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final VemRepository vemRepository;
  final VemResponseRepository vemResponseRepository;
  final FirebaseUserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<VemsBloc>(
            create: (context) =>
                VemsBloc(vemRepository: vemRepository)..add(LoadVems()),
          ),
          BlocProvider<VemResponsesBloc>(
            create: (context) =>
                VemResponsesBloc(vemResponseRepository: vemResponseRepository)
                  ..add(LoadVemResponses()),
          ),
          BlocProvider<UsersBloc>(
            create: (context) =>
                UsersBloc(userRepository: userRepository)
                  ..add(LoadCurrentUser()),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      return MaterialApp(
        theme: theme.getTheme(),
        navigatorKey: _navigatorKey,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
          AddEditVemScreen.routeName: (context) => AddEditVemScreen(),
          VemDetailsScreen.routeName: (context) => VemDetailsScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(selectedIndex: 2,),
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
    });
  }
}

// TODO !!!!
/* This code is for the add-edit screen so I don't forget it
* Place in routes when ready
AddEditVemScreen(
                    onSave: (
                      name,
                      startDate,
                      endDate,
                      lockDate,
                      responseType,
                      description,
                      minParticipants,
                      maxParticipiants,
                    ) {
                      BlocProvider.of<VemsBloc>(context).add(
                        AddVem(Vem(
                          name,
                          responseType,
                          description: description,
                          startDate: startDate,
                          endDate: endDate,
                          lockDate: lockDate,
                          minParticipants: minParticipants,
                          maxParticipants: maxParticipiants,
                        )),
                      );
                    },
                    isEditing: false,
                    vem: widget.vem,
                  ),
*/
