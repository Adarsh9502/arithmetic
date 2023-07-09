import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DialogWidget extends StatelessWidget {
  final List<String> steps;
  const DialogWidget({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Text(steps[index]);
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
          SizedBox(
            height: size.height / 25,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
              backgroundColor: AppColors.yellow,
            ),
            child: Icon(
              Icons.close,
              color: AppColors.background,
              size: size.width / 10,
            ),
          )
        ],
      ),
    );
  }
}
