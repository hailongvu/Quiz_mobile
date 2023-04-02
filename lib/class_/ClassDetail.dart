import 'package:flutter/material.dart';

class ClassDetail extends StatelessWidget {
  final bool a = true;

  const ClassDetail({super.key}); // replace this with your actual boolean value

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: RichText(
            textAlign: TextAlign.left,
            // ignore: prefer_const_constructors
            text: TextSpan(
              text: "Class name",
              style: const TextStyle(fontSize: 16),
              // ignore: prefer_const_literals_to_create_immutables
              children: <TextSpan>[
                const TextSpan(
                  text: '\nNumber of set',
                  style: TextStyle(
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sets'),
              Tab(text: 'Folders'),
              Tab(text: 'Members'),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (result) {
                // Add your code here to handle the selected menu item
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'invite',
                  child: Text('Invite member'),
                ),
                const PopupMenuItem(
                  value: 'addSet',
                  child: Text('Add more set'),
                ),
                const PopupMenuItem(
                  value: 'addFolder',
                  child: Text('Add more folder'),
                ),
                const PopupMenuItem(
                  value: 'report',
                  child: Text('Report'),
                ),
                const PopupMenuItem(
                  value: 'leave',
                  child: Text('Leave class'),
                ),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            if (a)
              Card(
                elevation: 2.0,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 270),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  // ignore: prefer_const_constructors
                  side: BorderSide(
                    color: Colors.blue, // change color here
                    width: 2.0, // change width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "This class has no sets",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        "Add an existing set or create a new one to share.",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Add your code here to handle the button press
                        },
                        child: const Text("Add a set"),
                      ),
                    ],
                  ),
                ),
              )
            else
              Card(
                elevation: 2.0,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 320),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  // ignore: prefer_const_constructors
                  side: BorderSide(
                    color: Colors.blue, // change color here
                    width: 2.0, // change width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "My set",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        "Terms",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        "Author",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const Center(child: Text('Folder')),
            const Center(child: Text('Member')),
          ],
        ),
      ),
    );
  }
}
