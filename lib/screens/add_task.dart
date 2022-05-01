import 'package:crud_flutter/colors/app_colors.dart';
import 'package:crud_flutter/widgets/button_widget.dart';
import 'package:crud_flutter/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();
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
                  onPressed: () {},
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
                    textController: nameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFieldWidget(
                      textController: detailController,
                      textHint: 'Details',
                      borderRadius: 15,
                      maxLine: 5,
                    )),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ButtonWidget(
                      backgroundColor: AppColors.mainColor,
                      text: 'Add',
                      textColor: Colors.white),
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
