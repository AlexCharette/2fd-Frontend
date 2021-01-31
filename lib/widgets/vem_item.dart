import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regimental_app/app.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:regimental_app/widgets/widgets.dart';
import 'package:vem_repository/vem_repository.dart';

class VemItem extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final Vem vem;
  final int numParticipants;
  final bool isAttending;

  VemItem({
    Key key,
    @required this.onTap,
    @required this.onLongPress,
    @required this.vem,
    @required this.numParticipants,
    @required this.isAttending,
  }) : super(key: key);

  // bool _isFull() {
  //   if (vemResponses == null) return false;
  //   return (vemResponses.length == vem.maxParticipants);
  // }

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
      trailing: Container(
        width: MediaQuery.of(context).size.width / 4,
        child: Row(
          children: <Widget>[
            isAttending
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.buttonGreen,
                  )
                : Container(),
            SizedBox(
              width: 10,
            ),
            CompletionIcon(vem: vem),
          ],
        ),
      ),
    );
  }
}
