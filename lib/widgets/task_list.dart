import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function deleteTask;

  TaskList(this.tasks, this.deleteTask);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: tasks.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'There are currently no tasks.',
                    style: Theme.of(context).textTheme.title,
                  ),
                  //add image here in a container
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/sleepy-worker-at-work.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: FittedBox(
                          child: Image.asset(
                            'assets/images/file.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tasks[index].description,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    subtitle: Text(
                      DateFormat.jm().format(tasks[index].time),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text(
                              'Delete',
                              style: TextStyle(fontFamily: 'Lato'),
                            ),
                            onPressed: () => deleteTask(tasks[index].id),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteTask(tasks[index].id),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
              },
              //itemCount allows us to only see the number of tasks that are in task list
              //without itemCount, there would be an infitine number of items in listview.builder
              itemCount: tasks.length,
            ),
    );
  }
}
