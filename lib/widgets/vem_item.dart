import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  bool _isFull() {
    if (vemResponses == null) return false;
    return (vemResponses.length == vem.maxParticipants);
  }

  @override
  Widget build(BuildContext context) {
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
            // style ?
          ),
        ),
      ),
      subtitle: vem.startDate != null
          ? Text('Date: ${vem.startDate} - ${vem.endDate}')
          : null,
      trailing: Icon(_isFull()
          ? Icons.check_circle_sharp
          : Icons.check_circle_outline_sharp),
      // TODO trailing: const VemAttendanceIcon,
    );
  }
}
