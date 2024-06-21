import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/entidade/produto_entity.dart';

class ProdutoController with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ProdutosEntity>> pegarProduto() {
    return _firestore.collection('produtos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProdutosEntity.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> adicionarProduto(ProdutosEntity product) {
    return _firestore
        .collection('produtos')
        .add(product.toJson())
        .then((value) {})
        .catchError((error) {
      throw Exception(error);
    });
  }

  Future<void> deletarProduto(String id) {
    return _firestore
        .collection('produtos')
        .doc(id)
        .delete()
        .then((value) {})
        .catchError((error) {
      throw Exception(error);
    });
  }
}