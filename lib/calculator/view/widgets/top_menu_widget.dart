import 'package:calculator/app/utils/neumorphism_extension.dart';
import 'package:calculator/calculator/view/widgets/custom_dropdown_widget.dart';
import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget {
  const TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        const Icon(Icons.sunny).addNeumorphism(),
        const Spacer(),
        CustomDropdownMenu(
          borderRadius: BorderRadius.circular(10),
          backgroundColor: const Color.fromARGB(179, 245, 245, 245),
          icons: const [
            Icon(Icons.history, size: 30),
            Icon(Icons.info_outline_rounded, size: 30),
          ],
          onChange: (index) {},
        ).addNeumorphism(offset: const Offset(10, 5)),
        const SizedBox(width: 2),
      ],
    );
  }
}
