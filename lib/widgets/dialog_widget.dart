import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_colors.dart';

class DialogWidget extends StatelessWidget {
  final List<String> steps;
  final bool result;
  const DialogWidget({super.key, required this.steps, this.result = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                steps.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          return Text(steps[index]);
                        },
                        separatorBuilder: (_, __) => const Divider(),
                      )
                    : const Text('No Steps to Show'),
                result
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: size.height / 25),
                        child: const Text(
                          'Long Press on Steps icon to reveal the solution.',
                          maxLines: 2,
                          style: TextStyle(fontSize: 10, letterSpacing: 0.5),
                        ),
                      )
              ],
            ),
          ),
          SizedBox(
            height: size.height / 25,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pop(context);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
              backgroundColor: AppColors.yellow,
            ),
            child: Icon(
              Icons.close,
              color: AppColors.background,
              size: size.width / 15,
            ),
          )
        ],
      ),
    );
  }
}
