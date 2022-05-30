import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/colors/app_colors.dart';
import 'package:crud_flutter/screens/add_task.dart';
import 'package:crud_flutter/screens/home_screen.dart';
import 'package:crud_flutter/screens/task_details.dart';
import 'package:crud_flutter/widgets/button_widget.dart';
import 'package:crud_flutter/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/textfield_widget.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  final CollectionReference _taskTable =
      FirebaseFirestore.instance.collection('task_table');

  Future<void> _delete(String taskTableId) async {
    await _taskTable.doc(taskTableId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully delete a task')));
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _detailController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name_task'];
      _detailController.text = documentSnapshot['detail_task'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF2e3253),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      alignment: Alignment.centerLeft,
    );

    final rightEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.delete,
          color: Colors.black,
        ),
      ),
      alignment: Alignment.centerRight,
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20, top: 80),
            child: InkWell(
                onTap: () {
                  Get.to(HomeScreen());
                },
                child: Icon(Icons.arrow_back)),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/header01.png'),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(HomeScreen());
                  },
                  child: Icon(
                    Icons.home,
                    color: AppColors.secondaryColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(AddTask());
                  },
                  child: Container(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Icon(
                  Icons.calendar_today,
                  color: AppColors.secondaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '2',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              child: StreamBuilder(
            stream: _taskTable.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Dismissible(
                        background: leftEditIcon,
                        secondaryBackground: rightEditIcon,
                        onDismissed: (DismissDirection direction) =>
                            _delete(documentSnapshot.id),
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    height: 300,
                                    width: double.maxFinite,
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // Get.to(TaskDetails(
                                              //   index: index,
                                              // ));

                                              Get.defaultDialog(
                                                title: "",
                                                content: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      documentSnapshot[
                                                          'name_task'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(documentSnapshot[
                                                        'detail_task']),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: ButtonWidget(
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                text: 'View',
                                                textColor: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _update();
                                              Get.defaultDialog(
                                                  title: "Update",
                                                  content: Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    top: 10,
                                                                    right: 10),
                                                            child:
                                                                TextFieldWidget(
                                                              textHint:
                                                                  documentSnapshot[
                                                                      'name_task'],
                                                              borderRadius: 30,
                                                              textController:
                                                                  _nameController,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      top: 20,
                                                                      right:
                                                                          10),
                                                              child:
                                                                  TextFieldWidget(
                                                                textController:
                                                                    _detailController,
                                                                textHint:
                                                                    documentSnapshot[
                                                                        'detail_task'],
                                                                borderRadius:
                                                                    15,
                                                                maxLine: 5,
                                                              )),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                final String
                                                                    name =
                                                                    _nameController
                                                                        .text;
                                                                final String
                                                                    details =
                                                                    _detailController
                                                                        .text;
                                                                if (details !=
                                                                    null) {
                                                                  await _taskTable
                                                                      .doc(documentSnapshot!
                                                                          .id)
                                                                      .update({
                                                                    "name_task":
                                                                        name,
                                                                    "detail_task":
                                                                        details
                                                                  });
                                                                  _nameController
                                                                      .text = '';
                                                                  _detailController
                                                                      .text = '';
                                                                }
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: ButtonWidget(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .mainColor,
                                                                  text: 'Add',
                                                                  textColor:
                                                                      Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                            },
                                            child: ButtonWidget(
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                text: 'Edit',
                                                textColor:
                                                    AppColors.secondaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                            return false;
                          } else {
                            return Future.delayed(const Duration(seconds: 1),
                                () {
                              return direction == DismissDirection.endToStart;
                            });
                          }
                        },
                        key: UniqueKey(),
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: TaskWidget(
                              task: documentSnapshot['name_task'],
                              color: Colors.blueGrey),
                        ),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ))
        ],
      ),
    );
  }
}
