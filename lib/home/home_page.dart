import 'package:flutter/material.dart';
import 'package:myapp/models/produto_model.dart';
import 'package:myapp/home/home_controller.dart';
import 'package:myapp/produtos/produtos_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final HomeController ct = HomeController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProdutoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciador de Produtos'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _campoDeTexto(ct.nomeCT, 'Nome'),
              _campoDeTexto(ct.marcaCT, 'Marca'),
              _campoDeTexto(ct.precoCT, 'Preço', isNumeric: true),
              _campoDeTexto(ct.quantidadeCT, 'Quantidade', isNumeric: true),
              ElevatedButton(
                onPressed: () {
                  if (ct.validarResposta(context)) {
                    final product = ProdutosModel(
                      id: '',
                      nome: ct.nomeCT.text,
                      marca: ct.marcaCT.text,
                      preco: ct.getPreco(),
                      quantidade: ct.getQuantidade(),
                    );
                    productController.adicionarProduto(product);
                    ct.limpar();
                  }
                },
                child: const Text('Adicionar Produto'),
              ),
              Expanded(
                child: StreamBuilder<List<ProdutosModel>>(
                  stream: productController.pegarProduto(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text('Erro: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    final produtosLista = snapshot.data!;

                    return ListView.builder(
                      itemCount: produtosLista.length,
                      itemBuilder: (context, index) {
                        final produtos = produtosLista[index];
                        return Card(
                          child: ListTile(
                            title: Text(produtos.nome),
                            subtitle: Text(
                                '${produtos.marca} - R\$ ${produtos.preco}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Excluir Produto'),
                                    content: const Text(
                                        'Deseja excluir este produto?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          productController
                                              .deletarProduto(produtos.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Confirmar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoDeTexto(TextEditingController controller, String labelText,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
