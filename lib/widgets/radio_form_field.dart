import 'package:flutter/material.dart';

class RadioFormField<T> extends FormField<T> {
  final T initialValue;
  final FormFieldSetter<T> onSaved;
  final FormFieldValidator<T> validator;
  final T currentValue;
  final T groupValue;
  final Function onChanged;

  RadioFormField({
    Key key,
    this.initialValue,
    this.currentValue,
    this.groupValue,
    this.onChanged,
    this.validator,
    this.onSaved,
  }) : super(
          key: key,
          builder: (FormFieldState<T> state) {
            return Column(
              children: <Widget>[
                Radio<T>(
                  value: currentValue,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
                //Text(alue.toString()),
              ],
            );
          },
        );

  @override
  _RadioFormFieldState<T> createState() => _RadioFormFieldState();
}

class _RadioFormFieldState<T> extends FormFieldState<T> {}
