import 'package:flutter/material.dart';

class RadioFormField<T> extends FormField<T> {
  final List<T> values;
  T groupValue;
  final Function onChanged;

  RadioFormField({
    Key key,
    this.values,
    this.onChanged,
    T groupValue,
    T initialValue,
    FormFieldValidator<T> validator,
    FormFieldSetter<T> onSaved,
  }) : super(
          key: key,
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          builder: (FormFieldState<T> state) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: values
                .map(
                  (value) => Column(
                    children: <Widget>[
                      Radio<T>(
                        value: value,
                        groupValue: groupValue,
                        onChanged: (val) {
                          print('value changed');
                          groupValue = val;
                        },
                      ),
                      Text('$value'),
                    ],
                  ),
                )
                .toList(),
          ),
        );

  @override
  _RadioFormFieldState<T> createState() => _RadioFormFieldState();
}

class _RadioFormFieldState<T> extends FormFieldState<T> {
  // T _currentValue;

  // Widget _buildWidget() {
  //   return Column(
  //     children: widget.values
  //         .map(
  //           (value) => Radio<T>(
  //             value: _currentValue ?? widget.initialValue,
  //             groupValue: widget.groupValue,
  //             onChanged: widget.onChanged,
  //           ),
  //           //Text(alue.toString()),
  //         )
  //         .toList(),
  //   );
  // }
}
