class ProdutosModel {
  String id;
  String nome;
  String marca;
  int preco;
  int quantidade;

  ProdutosModel({
    required this.id,
    required this.nome,
    required this.marca,
    required this.preco,
    required this.quantidade,
  });

  factory ProdutosModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProdutosModel(
      id: documentId,
      nome: data['nome']['stringValue'],
      marca: data['marca']['stringValue'],
      preco: int.parse(data['preco']['integerValue']),
      quantidade: int.parse(data['quantidade']['integerValue']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': {'stringValue': nome},
      'marca': {'stringValue': marca},
      'preco': {'integerValue': preco.toString()},
      'quantidade': {'integerValue': quantidade.toString()},
    };
  }
}
