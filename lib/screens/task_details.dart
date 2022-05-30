import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/screens/all_task.dart';
import 'package:crud_flutter/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TaskDetails extends StatelessWidget {
  final int index;

  const TaskDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _taskTable =
        FirebaseFirestore.instance.collection('task_table');
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20, top: 80),
            child: InkWell(
                onTap: () {
                  Get.to(AllTask());
                },
                child: Icon(Icons.arrow_back)),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: const BoxDecoration(

            ),
          ),
          StreamBuilder(
              stream: _taskTable.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                          child: TaskWidget(
                              task: documentSnapshot['name_task'],
                              color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 10,),
                        Text(documentSnapshot['detail_task']),
                      ],


                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
