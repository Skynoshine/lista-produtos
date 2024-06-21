import 'package:flutter/material.dart';
import 'package:myapp/home/popup.dart';

class HomeController {
  final TextEditingController nomeCT = TextEditingController();
  final TextEditingController marcaCT = TextEditingController();
  final TextEditingController precoCT = TextEditingController();
  final TextEditingController quantidadeCT = TextEditingController();

  int getQuantidade() {
    int quantity = int.tryParse(quantidadeCT.text) ?? 1;
    if (quantity == 0) {
      return quantity = 1;
    }
    return quantity;
  }

  int getPreco() {
    int price = int.tryParse(precoCT.text) ?? 1;
    if (price == 0) {
      return price = 1;
    }
    return price;
  }

  void limpar() {
    nomeCT.clear();
    marcaCT.clear();
    precoCT.clear();
    quantidadeCT.clear();
  }

  bool validarResposta(BuildContext context) {
    final price = int.tryParse(precoCT.text);
    final quantity = int.tryParse(quantidadeCT.text);

    if (nomeCT.text.isEmpty ||
        marcaCT.text.isEmpty ||
        precoCT.text.isEmpty ||
        quantidadeCT.text.isEmpty ||
        price == null ||
        quantity == null ||
        price <= 0 ||
        quantity <= 0) {
      showDialog(
        context: context,
        builder: (context) => Popup(
          showCancel: false,
          title: 'Insira um valor válido!',
          message:
              'Todos os campos devem ser preenchidos e o preço e a quantidade devem ser números',
          onConfirm: () => Navigator.of(context).pop(),
        ),
      );
      return false;
    }
    return true;
  }
}
