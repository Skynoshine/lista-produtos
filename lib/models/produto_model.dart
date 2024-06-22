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
