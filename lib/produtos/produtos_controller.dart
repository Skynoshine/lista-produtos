import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/produto_model.dart';

class ProdutoController with ChangeNotifier {
  final String apiUrl =
      'https://firestore.googleapis.com/v1/projects/gabrielspaniol-88239/databases/(default)/documents/produtos';

  Stream<List<ProdutosModel>> pegarProduto() async* {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<ProdutosModel> produtos = (data['documents'] as List).map((item) {
        return ProdutosModel.fromMap(
            item['fields'], item['name'].split('/').last);
      }).toList();
      yield produtos;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> adicionarProduto(ProdutosModel product) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'fields': product.toJson()}),
      );
      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception(
            'Failed to add product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to add product: $error');
    }
  }

  Future<void> deletarProduto(String id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (error) {
      throw Exception('Failed to delete product: $error');
    }
  }
}
