import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenSetting extends StatelessWidget {
  final String username = 'TaylorSwift'; // sample username
  final String email = 'TaylorSwift@example.com';

  const ScreenSetting({super.key}); // sample email

  Future<String> _editUsername(BuildContext context) async {
    String newUsername = username;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Username'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newUsername = value;
            },
            decoration: const InputDecoration(
              labelText: 'New username',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cancel
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, newUsername); // save new username
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    return newUsername;
  }

  Future<void> _changePassword(BuildContext context) async {
    String currentPassword = '';
    String newPassword = '';
    String reNewPassword = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                onChanged: (value) {
                  currentPassword = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  newPassword = value;
                },
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  reNewPassword = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Re-type New Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cancel
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newPassword == reNewPassword) {
                  // password match, perform update action
                  Navigator.pop(context);
                } else {
                  // passwords don't match, display error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'New password and re-type password do not match.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'About',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 8),
                Text(
                  'Developers:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text('- Ngo Tuan Anh'),
                Text('- Vu Hai Long'),
                Text('- Dao Xuan Dat'),
                Text('- Dang Cong Thanh'),
                Text('- Nguyen Quang Tuan'),
                SizedBox(height: 16),
                Divider(thickness: 1),
                SizedBox(height: 16),
                Text(
                  'Donate to support us:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text('Viettinbank - 103868532900'),
                SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Username'),
            subtitle: Text(username),
            onTap: () async {
              String newUsername = await _editUsername(context);
              if (newUsername.isNotEmpty) {
                // update username
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: Text(email),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change password'),
            onTap: () async {
              await _changePassword(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help center'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaterialApp(
                      theme: ThemeData(useMaterial3: true),
                      home: const WebViewApp()),
                ),
              ); // navigate to a help center screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () async {
              _showAboutDialog(context);
              // navigate to an about screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // perform logout action
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout all devices'),
            onTap: () {
              // perform logout action
            },
          ),
        ],
      ),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://google.com'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
