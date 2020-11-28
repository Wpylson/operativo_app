import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/item_size.dart';
import 'package:operativo_final_cliente/models/product.dart';

class CartProduct extends ChangeNotifier{
  CartProduct.froProduct(this._product){
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
    //date = DateTime.now() as Timestamp;
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;

    firestore.document('produtos/$productId').get().then(//pegar o produto refente aos dados do cart por id
            (doc) {
              product = Product.fromDocument(doc);
            }
    );
  }

  CartProduct.fromMap(Map<String,dynamic> map){
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;

    firestore.document('produtos/$productId').get().then(//pegar o produto refente aos dados do cart por id
            (doc) {
          product = Product.fromDocument(doc);
        }
    );
  }

  final Firestore firestore = Firestore.instance;

  String id;
  String productId;
  int quantity;
  String size;
  //Timestamp date; TODO: DATA DO PEDIDO

  num fixedPrice;

  Product _product;
  Product get product => _product;
  set product(Product value){
    _product = value;
    notifyListeners();//para trazer a tela do cart actualizada
  }

  //getter para retornar um tamanho
  ItemSize get itemSize{
    if(product == null) return null;
    return product.findSize(size);
  }

  //Getter para retornar Preço unitário do tamanho do produto in context
  num get unitPrice{
    if(product == null) return 0;
    return itemSize?.price ?? 0;//se preço null retorna 0;
  }

  //Pegar o preço total dos produtos do carrinho
  num get totalPrice => unitPrice * quantity;




  //Salvar os dados do cart
  Map<String,dynamic> toCartItemMap(){
    return{
      'pid' : productId,
      'quantity': quantity,
      'size' : size,
    };
  }

  //map dos dados para o pedido
  Map<String, dynamic>  toOrderItemMap(){
    return{
      'pid' : productId,
      'quantity': quantity,
      'size' : size,
      'fixedPrice': fixedPrice ?? unitPrice,//se ja tenho um fixed price setado cololo o proprio fixedPrice, caso naao...coloco o unitPrice
    };
  }


  //empilhar mesmos produtos no cart
  bool stackable(Product product){
    return product.id == productId && product.selectedSize.name == size;
  }

  //incremetar a quantidade
  void increment(){
    quantity++;
    notifyListeners();
  }

  //decrementar a quantidade
  void decrement(){
    quantity--;
    notifyListeners();
  }

  //Verificar o stock existente do produto
  bool get hasStock{
    if(product != null && product.deleted) return false;
    final size = itemSize;
    if(size == null){
      return false;
    }
    return size.stock >= quantity;
  }




}