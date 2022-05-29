import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/colors/app_colors.dart';
import 'package:crud_flutter/widgets/button_widget.dart';
import 'package:crud_flutter/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  final CollectionReference _taskTable =
      FirebaseFirestore.instance.collection('task_table');

  @override
  Widget build(BuildContext context) {
    List myData = ['Buy Milk', ' Buy Egg'];
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
                  Get.back();
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Icon(
                  Icons.home,
                  color: AppColors.secondaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
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
                builder: (context,AsyncSnapshot<QuerySnapshot>streamSnapshot){
                  if(streamSnapshot.hasData){
                    return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                          return Dismissible(
                            background: leftEditIcon,
                            secondaryBackground: rightEditIcon,
                            onDismissed: (DismissDirection direction) {},
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
                                              ButtonWidget(
                                                  backgroundColor:
                                                  AppColors.mainColor,
                                                  text: 'View',
                                                  textColor: Colors.white),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              ButtonWidget(
                                                  backgroundColor:
                                                  AppColors.mainColor,
                                                  text: 'Edit',
                                                  textColor:
                                                  AppColors.secondaryColor),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                return false;
                              } else {
                                return Future.delayed(const Duration(seconds: 1), () {
                                  return direction == DismissDirection.endToStart;
                                });
                              }
                            },
                            key: ObjectKey(index),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: TaskWidget(
                                  task: documentSnapshot['name_task'], color: Colors.blueGrey),
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
