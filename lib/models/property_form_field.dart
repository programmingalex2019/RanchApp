import 'package:flutter/material.dart';
import 'package:the_ranch_app/design/constants.dart';

class PropertyFormField extends StatelessWidget {
  const PropertyFormField({
    Key key,
    @required this.initialValue,
    @required this.onSaved,
    @required this.hintText,
    @required this.fieldName,
    this.validator,
    this.maxLines,
  }) : super(key: key);

  final String initialValue;
  final Function onSaved;
  final String hintText;
  final String fieldName;
  final int maxLines;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(
            fieldName,
            style: Theme.of(context).textTheme.button.copyWith(fontSize: 16.0),
          ),
          TextFormField(
            maxLines: maxLines,
            textAlign: TextAlign.center,
            initialValue: initialValue,
            validator: (value) => value.isNotEmpty ? null : 'Can\'t be empty',
            decoration: kTextFieldDesign.copyWith(hintText: hintText),
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}

class PropertyFormFieldGrade extends StatelessWidget {
  const PropertyFormFieldGrade({
    Key key,
    @required this.initialValue,
    @required this.onSaved,
    @required this.hintText,
    @required this.fieldName,
    this.validator,
    this.maxLines,
  }) : super(key: key);

  final String initialValue;
  final Function onSaved;
  final String hintText;
  final String fieldName;
  final int maxLines;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Text(
            fieldName,
            style: Theme.of(context).textTheme.button.copyWith(fontSize: 16.0),
          ),
          TextFormField(
            maxLines: maxLines,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            initialValue: initialValue,
            validator: (value) => value.isNotEmpty ? null : 'Can\'t be empty',
            decoration: kTextFieldDesign.copyWith(hintText: hintText),
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }
}
