import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/colors/app_colors.dart';
import 'package:crud_flutter/screens/all_task.dart';
import 'package:crud_flutter/widgets/button_widget.dart';
import 'package:crud_flutter/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final CollectionReference _taskTable =
      FirebaseFirestore.instance.collection('task_table');
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _detailController = TextEditingController();

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name_task'];
      _detailController.text = documentSnapshot['detail_task'];
    }
  }

  @override
  Widget build(BuildContext context) {
    _create();
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 5, right: 20),
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('img/header.png'),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.secondaryColor,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFieldWidget(
                    textHint: 'Task Name',
                    borderRadius: 30,
                    textController: _nameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFieldWidget(
                      textController: _detailController,
                      textHint: 'Details',
                      borderRadius: 15,
                      maxLine: 5,
                    )),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextButton(
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String details = _detailController.text;
                      if (details != null) {
                        await _taskTable
                            .add({"name_task": name, "detail_task": details});
                        _nameController.text = '';
                        _detailController.text = '';
                      }
                      Get.to(AllTask());
                    },
                    child: ButtonWidget(
                        backgroundColor: AppColors.mainColor,
                        text: 'Add',
                        textColor: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
          ],
        ),
      ),
    );
  }
}
