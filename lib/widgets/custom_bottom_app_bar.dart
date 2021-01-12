import 'package:flutter/material.dart';
import 'package:regimental_app/screens/home/home.dart';
import 'package:regimental_app/screens/profile/profile.dart';

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
          case 0:
            if (selectedIndex != index)
              Navigator.of(context).pushAndRemoveUntil(HomeScreen.route(), (route) => false);
            break;
          case 1:
              if (selectedIndex != index)
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
            break;
          case 2:
            if(selectedIndex != index)
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            break;
        }
      },
    );
  }
}
