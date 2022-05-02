import 'package:crud_flutter/colors/app_colors.dart';
import 'package:crud_flutter/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class AllTask extends StatelessWidget {
  const AllTask({Key? key}) : super(key: key);

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
            child: const Icon(Icons.arrow_back),
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
                  Icons.calendar_month,
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
              child: ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: leftEditIcon,
                      secondaryBackground: rightEditIcon,
                      onDismissed: (DismissDirection direction) {},
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
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
                            task: myData[index], color: Colors.blueGrey),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
