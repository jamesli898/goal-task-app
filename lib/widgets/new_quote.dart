import 'package:flutter/material.dart';

class NewQuote extends StatefulWidget {
  final Function updateQuote;
  NewQuote(this.updateQuote);

  @override
  _NewQuoteState createState() => _NewQuoteState();
}

class _NewQuoteState extends State<NewQuote> {
  final _quoteController = TextEditingController();

  void _submitData() {
    final enteredQuote = _quoteController.text;
    if (enteredQuote.isEmpty) {
      return;
    }
    widget.updateQuote(enteredQuote);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Quote'),
              controller: _quoteController,
              // with this wrapping anonymous function (the () =>), we have to pass the function like submitData() and not submitData
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 10,
            ),
            //AdaptiveRaisedButton(_submitData, 'Add Quote'),
            RaisedButton(
              child: Text('Add Quote'),
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          ],
        ),
      ),
    );
  }
}
