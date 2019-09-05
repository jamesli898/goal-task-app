import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveRaisedButton extends StatelessWidget {
  final Function handler;
  final String text;

  AdaptiveRaisedButton(this.handler, this.text);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoButton(
      child: Text('${text}'),
      onPressed: handler,
      color: Theme.of(context).primaryColor,
    )
    : RaisedButton(
      child: Text('${text}'),
      onPressed: handler,
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).textTheme.button.color,
    );
  }
}
