import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:client/util/user_storage.dart';

class Wait extends StatefulWidget {
  const Wait({super.key});

  @override
  State<Wait> createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  Map<String, dynamic>? user;

  Future<void> loadUser() async {
    final userData = await UserStorage.getUser();
    setState(() {
      user = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            user?['isApproved'] == false || user?['isApproved'] == "false"
                ? Text('Wait for Admin Approval...')
                : SizedBox.shrink(),
            if (user?['isApproved'] == true ||
                user?['isApproved'] == "true") ...[
              Text('You are Approved...\nRedirecting'),
              ProgressIndicatoring(),
            ],
          ],
        ),
      ),
    );
  }
}
