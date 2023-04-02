import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageNotify extends StatelessWidget {
  String message;

  MessageNotify(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.8,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: SizedBox(
                width: 300,
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(message, style: const TextStyle(color: Colors.red)),
                    ]),
              )),
        ),
      ],
    );
  }
}
