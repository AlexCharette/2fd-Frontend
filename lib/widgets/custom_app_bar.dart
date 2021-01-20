import 'package:flutter/material.dart';
import 'package:regimental_app/widgets/crest.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar(
      {@required this.appBarTitle, double preferredSize = 60.0, Key key})
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
    );
  }

  @override
  Size get preferredSize => _preferredSize;
}
