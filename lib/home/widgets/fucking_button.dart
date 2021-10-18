import 'package:flutter/material.dart';

class FuckingButton extends StatefulWidget {
  const FuckingButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback onPress;

  @override
  State<FuckingButton> createState() => _FuckingButtonState();
}

class _FuckingButtonState extends State<FuckingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimationRed;
  late Animation colorAnimationAmber;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    colorAnimationRed = ColorTween(
      begin: Colors.red,
      end: Colors.yellow,
    ).animate(controller);
    colorAnimationAmber = ColorTween(
      begin: Colors.yellow,
      end: Colors.red,
    ).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
      ),
      onPressed: widget.onPress,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
              colors: [colorAnimationRed.value, colorAnimationAmber.value]),
        ),
        child: Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text('F#@% Button')),
      ),
    );
  }
}
