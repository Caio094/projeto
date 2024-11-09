class Lista {
  final int? id;
  final String nome;

  Lista({this.id, required this.nome});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome};
  }

  factory Lista.fromMap(Map<String, dynamic> map) {
    return Lista(id: map['id'], nome: map['nome']);
  }
}
