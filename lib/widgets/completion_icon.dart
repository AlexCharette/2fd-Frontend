import 'package:flutter/material.dart';
import 'package:regimental_app/config/theme.dart';
import 'package:vem_repository/vem_repository.dart' show Vem;

class CompletionIcon extends StatelessWidget {
  final Vem vem;

  const CompletionIcon({this.vem});

  Widget build(BuildContext context) {
    if (vem.numParticipants < vem.minParticipants) {
      return Row(
        children: [
          Text(
            "${vem.numParticipants}/${vem.maxParticipants}",
            style: TextStyle(color: Colors.red[900]),
          ),
          Icon(
            Icons.people,
            color: Colors.red[900],
          ),
        ],
      );
    } else if (vem.numParticipants >= vem.minParticipants &&
        vem.numParticipants < vem.maxParticipants) {
      return Row(
        children: [
          Text(
            "${vem.numParticipants}/${vem.maxParticipants}",
            style: TextStyle(color: Colors.green[700]),
          ),
          Icon(
            Icons.check_circle_outline,
            color: Colors.white54,
            size: 35,
          ),
        ],
      );
    } else if (vem.numParticipants == vem.minParticipants) {
      return Icon(
        Icons.check_circle,
        color: AppColors.white,
        size: 35,
      );
    } else {
      return Container();
    }
  }
}
