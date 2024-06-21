class ProdutosEntity {
  String id;
  String nome;
  String marca;
  int preco;
  int quantidade;

  ProdutosEntity({
    required this.id,
    required this.nome,
    required this.marca,
    required this.preco,
    required this.quantidade,
  });

  factory ProdutosEntity.fromMap(Map<String, dynamic> data, String documentId) {
    return ProdutosEntity(
      id: documentId,
      nome: data['nome'],
      marca: data['marca'],
      preco: data['preco'],
      quantidade: data['quantidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'marca': marca,
      'preco': preco,
      'quantidade': quantidade,
    };
  }
}
