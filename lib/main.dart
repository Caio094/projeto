import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/home_screen.dart';

void main() {
  // Inicializa o `sqflite_ffi` para ambientes que não possuem suporte direto ao `sqflite`
  sqfliteFfiInit();
  
  // Define o `databaseFactory` para `databaseFactoryFfi`
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Listagem',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

