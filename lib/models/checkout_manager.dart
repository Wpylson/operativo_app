import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:operativo_final_cliente/models/order.dart';
import 'package:operativo_final_cliente/models/product.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // ignore: use_setters_to_change_properties
  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function onStockFail, Function onSuccess}) async {
    loading = true;
    try {
      //verifiar se tem stock disponivel e decrementamos
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    //TODO: Processar o pagamento

    final orderId = await _getOrderId(); //numero do pedido

    final order = Order.fromCartManager(cartManager); //objecto do pedido
    order.orderId = orderId.toString();

    order.save();

    cartManager.clear();

    onSuccess(order);
    loading = false;
  }

  //Metodo para pegar ID unico do pedido
  Future<int> _getOrderId() async {
    final ref = firestore.doc('aux/ordercounter'); //pegar o doc no firestores
    try {
      final result = await firestore.runTransaction(
        (tx) async {
          //Transacao
          final doc = await tx.get(ref); //ler doc do firestore
          final orderId = doc['current']
              as int; //atribuir na var orderId o valor actual da bd
          tx.update(ref, {
            'current': orderId + 1
          }); //pegar o valor e actualizar com +1 para torna-lo sempre unico
          return {'orderId': orderId};
        }, //timeout: const Duration(seconds: 10),
      );
      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Falha ao gerar número do pedido');
    }
  }

  Future<void> _decrementStock() {
    // 1. Ler todos os stock
    // 2. Decremento localmente os stock
    // 3. Salvar os stock no firebase

    return firestore.runTransaction((tx) async {
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];

      for (final cartProduct in cartManager.items) {
        //permite acessar cada um dos cartProduto
        //Verificar se o produto que esta no cart ja se encontra na listaproductsToUpdate = [] para evitar que tamanhos diferentes de do mesmo produto entram em conflito na hora de decrementar
        Product product;
        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product =
              productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx.get(firestore.doc(
                  'produtos/${cartProduct.productId}') //stock actual do produto
              );
          product = Product.fromDocument(doc);
        }

        cartProduct.product = product;

        //Verificar se o produto tem stock
        final size = product.findSize(cartProduct.size);
        if (size.stock - cartProduct.quantity <= 0) {
          //Falhar
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error(
            '${productsWithoutStock.length} produto(s) sem stock');
      }

      for (final product in productsToUpdate) {
        tx.update(
          firestore.doc('produtos/${product.id}'),
          {'sizes': product.exportSizeList()},
        );
      }
    });
  }
}
