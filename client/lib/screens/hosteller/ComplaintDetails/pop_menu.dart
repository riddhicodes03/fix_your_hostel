import 'package:flutter/material.dart';

class StatusBadgeMenu extends StatefulWidget {
  final String status;
  final void Function(String) onStatusChanged;

  const StatusBadgeMenu({
    super.key,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  State<StatusBadgeMenu> createState() => _StatusBadgeMenuState();
}

class _StatusBadgeMenuState extends State<StatusBadgeMenu> {
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.status;
  }

  void updateStatus(String newStatus) {
    setState(() {
      currentStatus = newStatus;
    });

    widget.onStatusChanged(newStatus);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: updateStatus,
      itemBuilder: (context) => const [
        PopupMenuItem(value: "pending", child: Text("Pending")),
        PopupMenuItem(value: "in progress", child: Text("In Progress")),
        PopupMenuItem(value: "resolved", child: Text("Resolved")),
      ],

      // 👇 THIS IS THE CLICKABLE BADGE
      child: Container(
        padding: const EdgeInsets.only(top: 3, bottom: 3, right: 1, left: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(currentStatus, style: const TextStyle(fontSize: 16)),
            SizedBox(width: 3),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
