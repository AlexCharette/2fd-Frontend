import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/generated/l10n.dart';
import 'package:regimental_app/screens/profile/profile.dart';
import 'package:regimental_app/screens/request_list/request_list.dart';
import 'package:regimental_app/screens/screens.dart';
import 'package:regimental_app/screens/vem_list/vem_list.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vem_repository/vem_repository.dart' show Vem;

class HomeScreen extends StatefulWidget {
  static String routeName = Routes.home;
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  String _appBarTitle;

  String _getAppBarTitle() {
    if (_pageController.hasClients) {
      switch (_pageController.page.round()) {
        case 0:
          return S.of(context).titleVemList;
          break;
        case 1:
          return S.of(context).titleProfile;
          break;
        default:
          return S.of(context).titleRegimentName;
      }
    } else {
      return S.of(context).titleRegimentName;
    }
  }

  @override
  void initState() {
    super.initState();
    _appBarTitle = S.of(context).titleRegimentName;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final userState = context.watch<UsersBloc>().state;
        if (userState is CurrentUserLoading) {
          return CircularProgressIndicator();
        } else if (userState is CurrentUserLoaded) {
          final canAddVems = !(userState.currentUser is NormalMember);
          return CustomScaffold(
            appBarTitle: _appBarTitle,
            pageController: _pageController,
            body: PageView(
              onPageChanged: (index) =>
                  setState(() => _appBarTitle = _getAppBarTitle()),
              controller: _pageController,
              children: <Widget>[
                VemList(),
                ProfileScreen(),
              ],
            ),
            floatingActionButtons: (_pageController.positions.isNotEmpty &&
                    _pageController.page.round() != 1 &&
                    canAddVems)
                ? FloatingActionButton(
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AddEditVemScreen.routeName,
                        arguments: AddEditVemScreenArguments(
                          null,
                          (
                            name,
                            startDate,
                            endDate,
                            lockDate,
                            responseType,
                            description,
                            minParticipants,
                            maxParticipants,
                          ) {
                            BlocProvider.of<VemsBloc>(context).add(AddVem(
                              Vem(
                                name,
                                responseType,
                                startDate: startDate,
                                endDate: endDate,
                                lockDate: lockDate,
                                description: description,
                                minParticipants: minParticipants,
                                maxParticipants: maxParticipants,
                              ),
                            ));
                          },
                          false,
                        ),
                      );
                    },
                  )
                : null,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
