import 'package:flutter/material.dart';

class RanchButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  const RanchButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      child: RaisedButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.button.copyWith(fontSize: 16.0),
        ),
        color: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            side: BorderSide(
              color: Theme.of(context).focusColor,
              width: 4,
            )),
        onPressed: onPressed,
      ),
    );
  }
}
