import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key,required this.message, required this.onTap});
  final String message;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.check_circle, color: Colors.green, size: 50),
        ],
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      actions: [
        Align(
          alignment: AlignmentGeometry.center,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            onPressed: onTap,
            child: const Text("OK"),
          ),
        ),
      ],
    );
  }
}
