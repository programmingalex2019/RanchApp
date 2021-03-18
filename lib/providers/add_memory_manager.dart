import 'package:flutter/material.dart';

class MemoryProvider {

  bool validator(String value) {
    return value.isNotEmpty;
  }

  void validate(GlobalKey<FormState> _formKey) {
    bool validate = _formKey.currentState.validate();
    if (validate) {
      _formKey.currentState.save();
    }
  }



}