import 'package:flutter/material.dart';

class DateDisplay extends StatelessWidget {
  final IconData icon;
  final String date;
  GestureTapCallback onTap;

  DateDisplay({
    this.icon,
    this.date,
    GestureTapCallback onTap,
  }) : this.onTap = onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: theme.primaryColor,
          ),
          SizedBox(height: 5),
          Text(
            date,
            style: theme.textTheme.bodyText2,
          )
        ],
      ),
    );
  }
}
