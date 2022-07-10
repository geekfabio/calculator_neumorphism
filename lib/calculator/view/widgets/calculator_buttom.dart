// ignore_for_file: inference_failure_on_function_return_type

import 'package:calculator/app/utils/neumorphism_extension.dart';
import 'package:calculator/app/utils/ripple_extension.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatefulWidget {
  const CalculatorButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  final Function() onPressed;

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isElevated = true;

  void _pressedDown(PointerEvent details) {}

  void _pressedUp(PointerEvent details) {
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Listener(
          onPointerDown: _pressedDown,
          onPointerUp: _pressedUp,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isElevated
                  ? [
                      const BoxShadow(
                        color: Color.fromARGB(255, 190, 213, 253),
                        offset: Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Theme.of(context).splashColor,
                        offset: const Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontSize: deviceHeight < 675 ? 30 : 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).ripple(
              () {},
            ),
          ).addNeumorphism(),
        ),
      ),
    );
  }
}
