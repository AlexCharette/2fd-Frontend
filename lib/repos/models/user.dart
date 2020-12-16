import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.name, this.digits, this.partner)
      : assert(digits >= 0 && digits < 1000);

  final String name;
  final int digits;
  final String partner;

  @override
  List<Object> get props => [name, digits, partner];

  String get id => name + digits.toString();

  static const empty = User('-', 0, '-');
}
