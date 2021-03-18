import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/common/platform_exception_alert_dialog.dart';
import 'package:the_ranch_app/services/auth.dart';

class LoginScreenProvider {
  AuthBase _auth = Auth();

  bool validator(String value) {
    return value.isNotEmpty;
  }

  void validate(GlobalKey<FormState> _formKey) {
    bool validate = _formKey.currentState.validate();
    if (validate) {
      _formKey.currentState.save();
    }
  }

  Future<void> onFormSaved(
      String email, String password, BuildContext context) async {
    final loadingStateManager = Provider.of<LoadingStateManager>(context);

    try {
      // change loading state
      loadingStateManager.changeLoadingState(true);
      await _auth.signInWithEmailAndPassword(email, password);
      loadingStateManager.changeLoadingState(false);
    } on PlatformException catch (e) {
      loadingStateManager.changeLoadingState(false);
      return PlatformExceptionAlertDialog(title: 'Oops', exception: e)
          .show(context);
    }
  }
}

// loading state throughout the app provider

class LoadingStateManager extends ChangeNotifier {
  bool isLoading = false;

  void changeLoadingState(bool loadingState) {
    isLoading = loadingState;
    notifyListeners();
  }
}
