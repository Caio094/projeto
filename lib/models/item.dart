// models/item.dart
class Item {
  final int? id;
  final String nome;
  final double preco;
  final int listaId;

  Item({this.id, required this.nome, required this.preco, required this.listaId});

  // Converter um objeto Item para um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'preco': preco,
      'listaId': listaId,
    };
  }
}
