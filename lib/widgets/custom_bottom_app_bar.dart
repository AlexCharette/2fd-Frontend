import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  CustomBottomAppBar({this.selectedIndex});
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: Theme.of(context).accentColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: 'VEMs',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Demandes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (int index){
        //TODO: implement the routes to the selected tab
        switch(index){
          case 1:
            //Navigator.of(context).pushAndRemoveUntil(newRoute, (route) => false)
            break;
          case 2:
            //Navigator.of(context).pushAndRemoveUntil(newRoute, (route) => false)
            break;
          case 3:
            //Navigator.of(context).pushAndRemoveUntil(newRoute, (route) => false)
            break;
        }
      },
    );
  }
}
