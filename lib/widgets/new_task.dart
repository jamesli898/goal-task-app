import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewTask extends StatefulWidget {
  final Function addTask;
  NewTask(this.addTask);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _descriptionController = TextEditingController();
  DateTime _selectedTime;

  void _submitData() {
    if (_descriptionController.text.isEmpty) {
      return;
    }
    final enteredDescription = _descriptionController.text;
    if (enteredDescription.isEmpty || _selectedTime == null) {
      return;
    }
    //above 2 lines check to see if the descriptions and time are empty, because if so, then nothing can be submitted
    //this became widget.addTx instead of addTx to access the properties and methods of the widget class inside the state class.
    widget.addTask(
      enteredDescription,
      _selectedTime,
    );
    Navigator.of(context).pop();
  }

  void _presentTimePicker() {
    Platform.isIOS
        ? showModalBottomSheet(
            context: context,
            builder: (BuildContext builder) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime pickedTime) {
                    if (pickedTime == null) {
                      return;
                    }
                    setState(() {
                      _selectedTime = DateTime(
                          2019, 1, 1, pickedTime.hour, pickedTime.minute);
                    });
                  },
                ),
              );
            })
        : showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 0, minute: 0),
          ).then((pickedTime) {
            if (pickedTime == null) {
              return;
            }
            setState(() {
              _selectedTime =
                  DateTime(2019, 1, 1, pickedTime.hour, pickedTime.minute);
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      //this column will description box and time selecter box.
      child: Container(
        padding: EdgeInsets.all(10),
        height: 500,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Task Description'),
              controller: _descriptionController,
              //onSubmitted: ...,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  //this expanded will expand the no time chosen text and leave the "choose time" to be on the right side of the screen
                  Expanded(
                    child: Text(
                      _selectedTime == null
                          ? 'No Time Chosen!'
                          : 'Task Time: ${DateFormat.jm().format(_selectedTime)}',
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentTimePicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text('Add Task'),
                  onPressed: _submitData,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
