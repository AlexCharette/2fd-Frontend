import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatefulWidget {
  final PageController pageController;

  CustomBottomAppBar({Key key, this.pageController}) : super(key: key);

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    _selectedIndex =
        (widget.pageController != null && widget.pageController.hasClients)
            ? widget.pageController.page.round()
            : _selectedIndex;
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).accentColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.notification_important),
          label: 'VEMs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (int index) {
        setState(() => _selectedIndex = index);

        widget.pageController.animateToPage(
          index,
          duration: new Duration(milliseconds: 250),
          curve: Curves.bounceInOut,
        );
        //TODO: implement the routes to the selected tab
        // switch (index) {
        //   case 0:
        //     if (selectedIndex != index)
        //       Navigator.of(context)
        //           .pushAndRemoveUntil(HomeScreen.route(), (route) => false);
        //     break;
        //   case 1:
        //     if (selectedIndex != index)
        //       Navigator.of(context).pushNamed(ProfileScreen.routeName);
        //     break;
        //   case 2:
        //     if (selectedIndex != index)
        //       Navigator.of(context).pushNamed(ProfileScreen.routeName);
        //     break;
        // }
      },
    );
  }
}
