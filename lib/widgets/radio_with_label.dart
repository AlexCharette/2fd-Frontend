import 'package:flutter/material.dart';

class RadioWithLabel<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final Function onChanged;

  const RadioWithLabel({
    this.value,
    this.groupValue,
    this.title,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (value) => onChanged(value),
      child: Column(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(title),
        ],
      ),
    );
  }
}
