import 'package:flutter/material.dart';
import 'package:regimental_app/blocs/authentication/authentication.dart';
import 'package:regimental_app/screens/home/view/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_app_bar.dart';
import 'custom_bottom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({this.appBarTitle, this.body, this.displayBottomAppBar = true, this.selectedIndex = 0, this.floatingActionButtons = null});

  final Widget body;
  final Widget floatingActionButtons;
  final String appBarTitle;
  final bool displayBottomAppBar;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: appBarTitle,),
       endDrawer: Drawer(
         child: Container(
           decoration: BoxDecoration(
               gradient: LinearGradient(
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                   colors: [Colors.red, Colors.blue]
               ),
           ),
           child: ListView(
             children: [
               //TODO: adjust to the real routes for now they all route to home
               ListTile(
                 leading: TextButton(
                   child: Text(
                     'EN',
                     style: Theme.of(context).textTheme.headline4,
                   ),
                   onPressed: (){
                     print('english');
                   },
                 ),
                 trailing: IconButton(
                     icon: Icon(Icons.close),
                     onPressed: (){
                       Navigator.pop(context);
                     },
                 ),
               ),
               ListTile(
                 trailing: Text('VEMS', style: Theme.of(context).textTheme.headline4,),
                 onTap: () => Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (route) => false),
               ),
               ListTile(
                 trailing: Text('DEMANDES', style: Theme.of(context).textTheme.headline4,),
                 onTap: () => Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (route) => false),
               ),
               ListTile(
                 trailing: Text('NOUVELLE VEM', style: Theme.of(context).textTheme.headline4,),
                 onTap: () => Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (route) => false),
               ),
               ListTile(
                 trailing: Text('MON PROFILE', style: Theme.of(context).textTheme.headline4,),
                 onTap: () => Navigator.of(context).pushAndRemoveUntil(HomePage.route(), (route) => false),
               ),
               ListTile(
                 trailing: Text('DÉCONNECTION', style: Theme.of(context).textTheme.headline4,),
                 onTap: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
               ),
             ],
           ),
         ),
       ),
       bottomNavigationBar: displayBottomAppBar ? CustomBottomAppBar(selectedIndex: selectedIndex,) : null,
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.red, Colors.blue]
                ),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/second-fd-app.appspot.com/o/assets%2Fimages%2Ftradition.jpg?alt=media&token=cd2f7c47-e7c9-449b-83ee-75ae3faa7782'
                    ),
                    fit: BoxFit.cover
                )
            ),
            child: SafeArea(child: body)
        ),
      ),
      floatingActionButton: floatingActionButtons
    );
  }
}
