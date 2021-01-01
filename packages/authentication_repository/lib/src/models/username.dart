import 'package:formz/formz.dart';
import 'package:email_validator/email_validator.dart';

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError validator(String value) {
    return value?.isNotEmpty == true && EmailValidator.validate(value) ? null : UsernameValidationError.invalid;
  }
}