import 'package:flutter/material.dart';
import 'package:task_manager_hasan/Api/apiCall.dart';
import 'package:task_manager_hasan/Api/urls.dart';
import 'package:task_manager_hasan/Models/taskCountSummery.dart';
import 'package:task_manager_hasan/Models/taskListModel.dart';
import 'package:task_manager_hasan/Screen/Home/addNewTask.dart';
import 'package:task_manager_hasan/Widget/ProfileWidget.dart';
import 'package:task_manager_hasan/Widget/taskItemList.dart';

class CancelTaskPage extends StatefulWidget {
  const CancelTaskPage({super.key});

  @override
  State<CancelTaskPage> createState() => _CancelTaskPageState();
}

class _CancelTaskPageState extends State<CancelTaskPage> {
  bool loader = false;
  bool countLoader = false;
  TaskListModal taskListModal = TaskListModal();
  TaskCount taskCount = TaskCount();

  Future<void> getNewTaskList()async {
    if(mounted){
      setState(() {
        loader = true;
      });
    }
    final ApiResponse response = await ApiRequest().getRequest(Urls.getCancelledTasks);
    if(response.isSuccess){
      taskListModal = TaskListModal.fromJson(response.jsonResponse??{});
    }
    print(Urls.getProgressTasks);
    if(mounted){
      setState(() {
        loader = false;
      });
    }
  }

  Future<void> getTaskCount()async {
    if(mounted){
      setState(() {
        countLoader = true;
      });
    }
    final ApiResponse response = await ApiRequest().getRequest(Urls.getTaskStatusCount);
    if(response.isSuccess){
      taskCount = TaskCount.fromJson(response.jsonResponse??{});
    }
    print('sk');
    if(mounted){
      setState(() {
        countLoader = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaskCount();
    getNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfileSection(enableOnTap: true),
            Expanded(child: Visibility(
              replacement: const Center(child: CircularProgressIndicator()),
              visible: !loader,
              child: ListView.builder(itemCount : taskListModal.data?.length??0, itemBuilder: (context, index) {
                return taskItemList(task: taskListModal.data![index], onStatusChange: () {
                  getNewTaskList();
                },
                  showProgress: (inProgress) {
                    loader = inProgress;
                    if (mounted) {
                      setState(() {});
                    }
                  },);
              },),
            ))
          ],
        ),
      ),
    );
  }
}

class Summery extends StatelessWidget {
  const Summery({
    super.key, required this.count, required this.title,
  });
  final String count,title;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
          child: Column(
            children: [
              Text(count ,style: Theme.of(context).textTheme.titleLarge,),
              Text(title),
            ],
          )
      ),
    );
  }
}
