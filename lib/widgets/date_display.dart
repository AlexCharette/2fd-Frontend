import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vem_repository/vem_repository.dart';

class DateDisplay extends StatefulWidget {
  final IconData icon;
  final Timestamp date;
  final GestureTapCallback onTap;

  const DateDisplay({
    Key key,
    this.icon,
    this.date,
    GestureTapCallback onTap,
  })  : this.onTap = onTap,
        super(key: key);

  @override
  DateDisplayState createState() => DateDisplayState();
}

class DateDisplayState extends State<DateDisplay> {
  String _date;

  updateDate(Timestamp newDate) {
    String dateStr = Vem.timestampToYearMonthDayTime(newDate);
    print('date updated!');
    setState(() => _date = dateStr);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var dateStr = _date ?? Vem.timestampToYearMonthDayTime(widget.date);
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: <Widget>[
          Icon(
            widget.icon,
            color: theme.primaryColor,
          ),
          SizedBox(height: 5),
          Text(
            dateStr.substring(dateStr.indexOf(' ') + 1),
            style: theme.textTheme.bodyText2,
          ),
          Text(
            dateStr.substring(0, dateStr.indexOf(' ')),
            style: theme.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
