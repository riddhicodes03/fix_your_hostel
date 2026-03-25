import 'package:client/screens/hosteller/ComplaintDetails/complaint_details.dart';
import 'package:client/screens/hosteller/widgets/empty_list.dart';
import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:client/screens/hosteller/widgets/raise_card.dart';
import 'package:flutter/material.dart';

import 'package:client/util/user_storage.dart';
import 'package:client/services/api.dart';

class MyIssues extends StatefulWidget {
  const MyIssues({super.key});

  @override
  State<MyIssues> createState() => _MyIssuesState();
}

class _MyIssuesState extends State<MyIssues> {
  List<String> selectedBlocks = [];
  String selectedVisibility = "all";
  String selectedStatus = "all";

  bool isUserLoading = true;
  bool isComplaintLoading = true;
  List<dynamic> _complaints = [];
  Map<String, dynamic>? user;
  @override
  void initState() {
    loadUser();
    fetchComplaints();

    super.initState();
  }

  Future<void> loadUser() async {
    var userData = await UserStorage.getUser();
    setState(() {
      user = userData;
      isUserLoading = false;
    });
    print("user data loged :${userData.toString()}");
  }

  void fetchComplaints() async {
    print('Fetching complaints from API...');
    Api api = Api();
    var data = await api.getComplaints(
      type: selectedVisibility == "all" ? null : selectedVisibility,
      status: selectedStatus == "all" ? null : selectedStatus,
    );

    setState(() {
      _complaints = data;
      isComplaintLoading = false;
    });
  }

  DropdownMenuItem<String> _buildItem(
    String value,
    String text,
    IconData icon,
  ) {
    return DropdownMenuItem(
      value: value,
      child: Row(
        children: [Icon(icon, size: 18), const SizedBox(width: 10), Text(text)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show a centered boxed loader while user or complaints are loading

    return Scaffold(
      appBar: AppBar(
        title: Text('My Issues'),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(30),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedStatus,
                icon: const Icon(Icons.expand_more, size: 20),
                borderRadius: BorderRadius.circular(12),
                dropdownColor: Theme.of(context).colorScheme.surface,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),

                items: [
                  _buildItem("all", "All", Icons.list),
                  _buildItem("pending", "Pending", Icons.hourglass_bottom),
                  _buildItem("in progress", "In Progress", Icons.sync),
                  _buildItem("resolved", "Resolved", Icons.check_circle),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                  fetchComplaints();
                },
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: (isComplaintLoading || isUserLoading)
          ? ProgressIndicatoring()
          : _complaints.isEmpty
          ? EmptyList(message: 'No Complaints Reported Yet')
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    for (final complaint in _complaints)
                      if (complaint['createdBy']['name'] == user?['name'])
                        RaisedCard(
                          complaint: complaint,
                          onTap: () async {
                            final response = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ComplaintDetails(complaint: complaint),
                              ),
                            );
                            if (response == true) {
                              fetchComplaints();
                            }
                          },
                        ),
                  ],
                ),
              ),
            ),
    );
  }
}
