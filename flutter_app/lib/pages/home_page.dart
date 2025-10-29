import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'instructors_page.dart';
import 'infrastructure_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthService();
  int _index = 0;

  final _tabs = const [
    InstructorsPage(),
    InfrastructurePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bölüm Uygulaması'),
        actions: [
          IconButton(
            tooltip: 'Çıkış',
            onPressed: () async {
              await _auth.logout();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _tabs[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people), label: 'Eğitmenler'),
          NavigationDestination(icon: Icon(Icons.photo_album), label: 'Altyapı'),
        ],
        onDestinationSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}
