import 'package:flutter/material.dart';
import 'package:task_manager_hasan/Api/urls.dart';
import 'package:task_manager_hasan/Widget/BodyBackground.dart';
import 'package:task_manager_hasan/Widget/ProfileWidget.dart';

import '../../Api/apiCall.dart';
import '../../Widget/showSnackMessage.dart';

class addNewTask extends StatefulWidget {
  const addNewTask({super.key});

  @override
  State<addNewTask> createState() => _addNewTaskState();
}

class _addNewTaskState extends State<addNewTask> {
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _myForm = GlobalKey<FormState>();
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileSection(enableOnTap: false),
            Expanded(child: BodyBackground(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _myForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32,),
                        Text('Add new task',style: Theme.of(context).textTheme.titleLarge,),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: _subjectController,
                          decoration: const InputDecoration(
                              hintText: 'Title'
                          ),
                          validator: (value) {
                            if(value==null || value.trim().isEmpty){
                              return 'Please enter subject';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          maxLines: 5,
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                          ),
                          validator: (value) {
                            if(value==null || value.trim().isEmpty){
                              return 'Please enter description';
                            }
                          },
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(width: double.infinity,
                          child: Visibility(
                            visible: !loader,
                            replacement: const Center(child: CircularProgressIndicator()),
                            child: ElevatedButton(onPressed: () async {
                              if(_myForm.currentState!.validate()){
                                setState(() {
                                  loader = true;
                                });
                                final ApiResponse response = await ApiRequest().postRequest(Urls.createNewTask, body: {
                                  'title' : _subjectController.text,
                                  'description' : _descriptionController.text,
                                  'status' : 'New'
                                });
                                setState(() {
                                  loader = false;
                                });
                                print(response.jsonResponse);
                                if(response.isSuccess){
                                  if(mounted){
                                    showSnackMessage(context,'Task create is successful');
                                    _subjectController.clear();
                                    _descriptionController.clear();
                                  }
                                }else{
                                  if(mounted){
                                    showSnackMessage(context,'Task create failed plz try again',true);
                                  }
                                }
                              }
                            },
                                child: const Icon(Icons.arrow_circle_right_outlined)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
  }
}
