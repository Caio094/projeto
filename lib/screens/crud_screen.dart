import 'package:flutter/material.dart';
import 'package:app_listagem/services/db_helper.dart';
import '../models/lista.dart';  // A importação correta da classe Lista

class CrudScreen extends StatefulWidget {
  CrudScreen({Key? key}) : super(key: key);

  @override
  _CrudScreenState createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final TextEditingController controller = TextEditingController();
  final DBHelper dbHelper = DBHelper();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Lista')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Nome da Lista',
                errorText: controller.text.isEmpty ? 'Por favor, insira um nome' : null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.text.isEmpty
                  ? null
                  : () async {
                      // Criando a nova lista
                      Lista novaLista = Lista(nome: controller.text);

                      // Tentando inserir no banco de dados
                      try {
                        await dbHelper.insertLista(novaLista);

                        // Limpar o campo de texto
                        controller.clear();

                        // Exibir mensagem de sucesso
                        setState(() {
                          message = 'Lista criada com sucesso!';
                        });

                        // Retornar para a tela anterior após o sucesso
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      } catch (e) {
                        setState(() {
                          message = 'Erro ao criar lista: $e';
                        });
                      }
                    },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 20),
            // Exibindo a mensagem de sucesso ou erro
            Text(
              message,
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
