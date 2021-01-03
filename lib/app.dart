import 'package:authentication_repository/authentication_repository.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/screens/home/view/home_page.dart';
import 'package:regimental_app/screens/login/view/login_page.dart';
import 'package:regimental_app/screens/splash/view/splash_page.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.vemRepository,
    @required this.vemResponseRepository,
  })  : assert(authenticationRepository != null),
        assert(vemRepository != null),
        assert(vemResponseRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final VemRepository vemRepository;
  final VemResponseRepository vemResponseRepository;

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
            create: (context) => VemsBloc(vemRepository: vemRepository),
          ),
          BlocProvider<VemResponsesBloc>(
            create: (context) =>
                VemResponsesBloc(vemResponseRepository: vemResponseRepository),
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
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(),
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
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
        onGenerateRoute: (_) => SplashPage.route(),
      );
    });
  }
}

// TODO !!!!
/* This code is for the add-edit screen so I don't forget it
* Place in routes when ready
* return AddEditVemScreen(
  onSave: (name, startDate, endDate, lockDate, responseType, 
    description, minParticipants, maxParticipiants,
  ) {
    BlocProvider.of<VemsBloc>(context).add(
      AddVem(Vem(__params__)),
    );
  },
  isEditing: false,
  vem: __some_vem__,
)
*/
