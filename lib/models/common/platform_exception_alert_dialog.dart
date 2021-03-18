import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:the_ranch_app/models/common/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
            title: title,
            content: _message(exception),
            defaultActionText: 'OK');

  static String _message(PlatformException exception) {
    if (exception.message == 'FIRFirestoreErrorDomain') {
      if (exception.code == 'Error 7') {
        return 'Missing or insufficient permissions';
      }
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WRONG_PASSWORD': 'The password is invalid',
    'ERROR_USER_NOT_FOUND': 'User not found',
    'ERROR_USER_DISABLED': 'User has been disabled',
    'ERROR_TOO_MANY_REQUESTS': 'Too many atempts!',
    'ERROR_NETWORK_REQUEST_FAILED': 'Please check your internet connection',
  };
}
