import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:vem_repository/vem_repository.dart';
import 'package:vem_response_repository/vem_response_repository.dart';

class VemItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final Vem vem;
  final List<VemResponse> vemResponses;

  VemItem({
    Key key,
    @required this.onTap,
    @required this.onLongPress,
    @required this.vem,
    @required this.vemResponses,
  }) : super(key: key);

  // bool _isFull() {
  //   if (vemResponses == null) return false;
  //   return (vemResponses.length == vem.maxParticipants);
  // }
  Widget completionIcon() {
    Widget completionStatus;

    if (vemResponses == null || vemResponses.length < vem.minParticipants) {
      print(vemResponses);
      completionStatus = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${vemResponses == null ? 0 : vemResponses.length}/${vem.maxParticipants}",
            style: TextStyle(color: Colors.red[900]),
          ),
          Icon(
            Icons.people,
            color: Colors.red[900],
            size: 35,
          ),
        ],
      );
    } else if (vemResponses.length >= vem.minParticipants &&
        vemResponses.length < vem.maxParticipants) {
      completionStatus = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${vemResponses.length}/${vem.maxParticipants}",
            style: TextStyle(color: Colors.green[700]),
          ),
          Icon(
            Icons.check_circle_outline,
            color: Colors.white54,
            size: 35,
          ),
        ],
      );
    } else if (vemResponses.length == vem.minParticipants) {
      completionStatus = Icon(
        Icons.check_circle,
        color: AppColors.white,
        size: 35,
      );
    } else {
      return null;
    }
    return completionStatus;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
        key: Key('__vem_item_${vem.id}'),
        onTap: onTap,
        onLongPress: onLongPress,
        title: Hero(
          tag: '${vem.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              vem.name,
              style: theme.textTheme.headline5,
            ),
          ),
        ),
        subtitle: vem.startDate != null
            ? Row(
                children: [
                  Text(
                    'Date: ${Vem.timestampToYearMonthDay(vem.startDate)}',
                    style: theme.textTheme.bodyText1
                        .copyWith(color: theme.primaryColor),
                  ),
                  vem.endDate != null
                      ? Text(
                          ' - ${Vem.timestampToYearMonthDay(vem.endDate)}',
                          style: theme.textTheme.bodyText1
                              .copyWith(color: theme.primaryColor),
                        )
                      : null,
                ],
              )
            : null,
        trailing: completionIcon());
  }
}
