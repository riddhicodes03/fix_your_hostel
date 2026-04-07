import 'package:client/screens/hosteller/account.dart';
import 'package:client/screens/hosteller/home.dart';
import 'package:client/screens/hosteller/my_issues.dart';
import 'package:flutter/material.dart';

class HostellerTabs extends StatefulWidget {
  const HostellerTabs({super.key});

  @override
  State<HostellerTabs> createState() => _HostellerTabsState();
}

class _HostellerTabsState extends State<HostellerTabs> {
  int _currentIndex = 0;
  final List<Widget> _pages = [Home(), MyIssues(), AccountScreen()];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      // this ensures the gap color matches your page background
      backgroundColor: scheme.surfaceContainerLowest,
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        backgroundColor: scheme.surfaceContainerHighest,
        indicatorColor: scheme.primaryContainer,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'My Issues',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
