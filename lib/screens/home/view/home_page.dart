import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:regimental_app/widgets/custom_app_bar.dart';
import 'package:regimental_app/widgets/custom_bottom_app_bar.dart';
import 'package:regimental_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

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
              child: VemList()
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
