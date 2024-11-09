import 'package:flutter/material.dart';
import 'list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Inicial')),
      body: Center(
        child: ElevatedButton(
          child: Text('Ver Listas'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListScreen()),
            );
          },
        ),
      ),
    );
  }
}
