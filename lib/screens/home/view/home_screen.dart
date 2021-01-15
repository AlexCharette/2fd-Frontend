import 'package:flutter/material.dart';
import 'package:regimental_app/config/routes.dart';
import 'package:regimental_app/screens/profile/profile.dart';
import 'package:regimental_app/screens/request_list/request_list.dart';
import 'package:regimental_app/screens/vem_list/vem_list.dart';
import 'package:regimental_app/widgets/widgets.dart';

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
  String _appBarTitle = '2FD';

  String _getAppBarTitle() {
    if (_pageController.hasClients) {
      switch (_pageController.page.round()) {
        case 0:
          return 'VEMS';
          break;
        case 1:
          return 'Requests';
          break;
        case 2:
          return 'Profile';
          break;
        default:
          return '2FD';
      }
    } else {
      return '2FD';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: _appBarTitle,
      pageController: _pageController,
      body: PageView(
        onPageChanged: (index) =>
            setState(() => _appBarTitle = _getAppBarTitle()),
        controller: _pageController,
        children: <Widget>[
          VemList(),
          RequestList(),
          ProfileScreen(),
        ],
      ),
      floatingActionButtons: (_pageController.positions.isNotEmpty &&
              _pageController.page.round() != 2)
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
              onPressed: () {
                //TODO: display other floating action buttons
              },
            )
          : null,
    );
  }
}
