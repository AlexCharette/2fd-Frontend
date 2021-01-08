import 'package:flutter/material.dart';
import 'package:regimental_app/widgets/crest.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({this.appBarTitle, double preferredSize = 60.0, Key key})
      : _preferredSize = Size.fromHeight(preferredSize),
        super(key: key);

  final String appBarTitle;
  final Size _preferredSize;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AppBar(
      title: Text(appBarTitle, style: theme.textTheme.headline2),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: Crest(),
      //IconButton(
      // //TODO: Solve the problems with the SVG
      // icon: SvgPicture.network(
      //     'https://firebasestorage.googleapis.com/v0/b/second-fd-app.appspot.com/o/assets%2Fimages%2Fcrest_custom.svg?alt=media&token=873ca5d0-48a6-4b91-8ef8-2bea26b17a77'),
      // iconSize: 40,
      // tooltip: 'Home',
      // onPressed: () {
      //   //TODO: send to home page
      // },
      //),
    );
  }

  @override
  Size get preferredSize => _preferredSize;
}
