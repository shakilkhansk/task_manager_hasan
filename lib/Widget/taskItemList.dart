import 'package:flutter/material.dart';
import 'package:task_manager_hasan/Api/apiCall.dart';
import 'package:task_manager_hasan/Api/urls.dart';

import '../Models/taskListModel.dart';
enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class taskItemList extends StatefulWidget {
  const taskItemList({super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
  });
  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;
  @override
  State<taskItemList> createState() => _taskItemListState();
}

class _taskItemListState extends State<taskItemList> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await ApiRequest()
        .getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.title??'', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text(widget.task.description??'',),
            Text('Date: ${widget.task.createdDate??''}',),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(widget.task.status??'New',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,),
                Row(
                  children: [
                    IconButton(onPressed: () {
                      showUpdateStatusModal();
                    }, icon: const Icon(Icons.edit, color: Colors.blue,),),

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
      title: Text(e.name),
      onTap: () {
        updateTaskStatus(e.name);
        Navigator.pop(context);
      },
    ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}

