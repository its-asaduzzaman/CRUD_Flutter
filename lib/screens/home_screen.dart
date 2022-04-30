import 'package:crud_flutter/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:crud_flutter/widgets/button_widget.dart';

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
            ButtonWidget(
                backgroundColor: AppColors.mainColor,
                text: 'Add Task',
                textColor: Colors.white),
            SizedBox(
              height: 20,
            ),
            ButtonWidget(
                backgroundColor: Colors.white,
                text: 'View All',
                textColor: AppColors.mainColor),
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
