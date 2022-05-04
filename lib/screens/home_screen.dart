import 'package:crud_flutter/colors/app_colors.dart';
import 'package:crud_flutter/screens/add_task.dart';
import 'package:crud_flutter/screens/all_task.dart';
import 'package:flutter/material.dart';
import 'package:crud_flutter/widgets/button_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.only(left: 20, top: 80, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Hello',
                style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '\n start your beautiful day',
                    style: TextStyle(
                      color: AppColors.smallTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () {
                    return const AddTask();
                  },
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 500),
                );
              },
              child: ButtonWidget(
                  backgroundColor: AppColors.mainColor,
                  text: 'Add Task',
                  textColor: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () {
                    return const AllTask();
                  },
                  transition: Transition.fade,
                  duration: const Duration(seconds: 1),
                );
              },
              child: ButtonWidget(
                  backgroundColor: Colors.white,
                  text: 'View All',
                  textColor: AppColors.mainColor),
            ),
          ],
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('img/welcome.png'),
          ),
        ),
      ),
    );
  }
}
