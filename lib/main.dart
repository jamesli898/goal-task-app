import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import './widgets/task_list.dart';
import './models/task.dart';
import './widgets/new_task.dart';
import './widgets/motivational_quote.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goal Setting',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.green,
        errorColor: Colors.red,
        //TextTheme specifies t he text styling for headlines, titles, bodies of text, and more.
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
              display1: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
              body2: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _userTasks = [
    /*Task(
      description: 'Feed the cat and the dog.',
      time: DateTime.now(),
      id: 't1',
    ),*/
  ];

  bool _showQuote = false;

  String _quote = 'You just can\'t beat the person who never gives up';

  void _addNewTask(String taskDescription, DateTime chosenTime) {
    //takes paramters and then uses them to create a new task object
    final newTask = Task(
      id: DateTime.now().toString(),
      description: taskDescription,
      time: chosenTime,
    );
    //adds the new task object to the list of tasks
    setState(() {
      _userTasks.add(newTask);
      print(newTask.description); //line for debugging
    });
  }

  void _deleteTask(String id) {
    setState(() {
      _userTasks.removeWhere((task) {
        return task.id == id;
      });
    });
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTask(
                _addNewTask,
              ),
            ),
          );
        });
  }

  void _updateQuote(String newInput) {
    setState(() {
      _quote = newInput;
    });
  }

  /*void _startAddNewQuote(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        child: NewQuote();
      );
    });
  }*/
  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Daily Task Planner',
              style: TextStyle(fontFamily: 'Lato'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add_circled),
                  onTap: () => _startAddNewTask(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Daily Task Planner',
              style: TextStyle(fontFamily: 'Lato'),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () => _startAddNewTask(context),
              ),
            ],
          );
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar) {
    return [
      Container(
        child: MotivationalQuote(_updateQuote, _quote),
        //if multiplied by more than 0.2, the image container gets moved down too much
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
      ),
      Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TaskList(_userTasks, _deleteTask),
    )
    ];
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show Quote', style: Theme.of(context).textTheme.title),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showQuote,
              onChanged: (val) {
                setState(() {
                  _showQuote = val;
                });
              }),
        ],
      ),
      _showQuote
          ? Container(
              child: MotivationalQuote(_updateQuote, _quote),
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
            )
          : Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  1.0,
              child: TaskList(_userTasks, _deleteTask),
            )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar),
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar)
        : Scaffold(
            //appBar uses appBarTheme for its formatting
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _startAddNewTask(context),
              tooltip: 'Add a new task',
              child: Icon(Icons.add),
            ),
          );
  }
}
