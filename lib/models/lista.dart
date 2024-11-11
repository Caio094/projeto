

class Lista {
  final int? id;
  final String nome;

  // Construtor
  Lista({this.id, required this.nome});

  // Método para converter um objeto Lista em um mapa (usado para inserir no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  // Método para criar um objeto Lista a partir de um mapa (usado para ler do banco)
  factory Lista.fromMap(Map<String, dynamic> map) {
    return Lista(
      id: map['id'],
      nome: map['nome'],
    );
  }
}
