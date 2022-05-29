import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class TaskDetails extends StatelessWidget {
  final int index;

  const TaskDetails({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _taskTable =
        FirebaseFirestore.instance.collection('task_table');
    return Scaffold(
      body: StreamBuilder(
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
    );
  }
}
