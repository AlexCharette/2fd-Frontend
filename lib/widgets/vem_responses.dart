import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regimental_app/blocs/blocs.dart';
import 'package:vem_response_repository/vem_response_repository.dart'
    show VemResponse;

class VemResponses extends StatelessWidget {
  final String vemId;
  final String format;

  const VemResponses({Key key, this.vemId, this.format = 'battery'})
      : super(key: key);

  Map<String, Map<String, List<String>>> _getGroupedResponses(
      List<VemResponse> responses) {
    Map<String, List<VemResponse>> responsesByDet =
        <String, List<VemResponse>>{};

    responses.forEach((response) {
      if (responsesByDet[response.detName] == null) {
        responsesByDet[response.detName] = <VemResponse>[];
      }
      responsesByDet[response.detName].add(response);
    });

    Map<String, Map<String, List<String>>> detResponsesByType =
        <String, Map<String, List<String>>>{};

    responsesByDet.entries.forEach((entry) {
      String detName = entry.key;
      List<VemResponse> detResponses = entry.value;
      detResponses.forEach((response) {
        if (detResponsesByType[detName] == null) {
          detResponsesByType[detName] = <String, List<String>>{};
        }
        if (detResponsesByType[detName][response.answer] == null) {
          detResponsesByType[detName][response.answer] = <String>[];
        }
        detResponsesByType[detName][response.answer].add(response.userInitials);
      });
    });

    return detResponsesByType;
  }

  List<String> _getDetNames(List<VemResponse> responses) {
    List<String> detNames = <String>[];

    responses.forEach(
      (response) => !detNames.contains(response.detName)
          ? detNames.add(response.detName)
          : null,
    );

    return detNames;
  }

  Widget _responseIcon(String answer) {
    switch (answer) {
      case 'yes':
        return Icon(Icons.check_circle);
        break;
      case 'no':
        return Icon(Icons.cancel);
        break;
      case 'seen':
        return Icon(Icons.remove_red_eye_rounded);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VemResponsesBloc, VemResponsesState>(
      builder: (context, state) {
        if (state is ResponsesForVemLoading) {
          return CircularProgressIndicator();
        } else if (state is ResponsesForVemLoaded) {
          final responses = state.vemResponses;

          if (responses == null || responses.isEmpty) {
            return Container(
              child: Text('there are no responses, yo'),
            );
          }

          final groupedResponses = _getGroupedResponses(responses);
          final detNames = _getDetNames(responses);

          return ListView.builder(
            itemCount: detNames.length, // For each det,
            shrinkWrap: true,
            itemBuilder: (context, detIndex) {
              final detName = groupedResponses.keys.elementAt(detIndex);
              return Container(
                child: ListView.separated(
                  separatorBuilder: (context, answerIndex) => Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  // For each answer type
                  itemCount: groupedResponses[detNames[detIndex]].length,
                  shrinkWrap: true,
                  itemBuilder: (context, answerIndex) {
                    final answer = groupedResponses[detNames[detIndex]]
                        .keys
                        .elementAt(answerIndex);
                    final initials =
                        groupedResponses[detNames[detIndex]][answer].toString();
                    return ListTile(
                      key: Key('__det_answer_${detName}_$answer'),
                      leading: _responseIcon(answer),
                      subtitle: Text(
                        '$answer : ${initials.substring(1, initials.length - 1)}',
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
