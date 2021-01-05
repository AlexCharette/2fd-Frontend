import 'package:flutter/material.dart';

import 'custom_app_bar.dart';
import 'custom_bottom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  CustomScaffold({this.body});

  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarTitle: 'VEMS',),
      bottomNavigationBar: CustomBottomAppBar(selectedIndex: 0,),
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
            child: body
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        onPressed: (){
          //TODO: display other floating action buttons
        },
      ),
    );
  }
}
