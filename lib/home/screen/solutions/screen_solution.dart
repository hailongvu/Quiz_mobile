import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ScreenSearch extends StatelessWidget {
  final _controller = TextEditingController();

  ScreenSearch({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.height,
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: ' Enter a lesson name',
                suffixIcon: IconButton(
                  onPressed: _controller.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            16.height,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {
                finish(context);
              },
              child: const Text("Search"),
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
