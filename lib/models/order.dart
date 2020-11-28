import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:operativo_final_cliente/models/address.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:operativo_final_cliente/models/cart_product.dart';

enum Status{ canceled, preparing, transporting, delivered}//conjunto de constantes
class Order{

  String orderId;
  List<CartProduct> items;
  num price;
  String userId;
  Address address;
  Timestamp date;
  Status status;
  //String lojaId;//Todo: lojaId no pedido
   DateTime novaData;




  final Firestore firestore = Firestore.instance;
  DocumentReference get firestoreRef =>
      firestore.collection('orders').document(orderId);

  //CRIAR PEDIDO
  Order.fromCartManager(CartManager cartManager){
    items = List.from(cartManager.items);//lista clone da CartManager
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
    status = Status.preparing;//estado base do pedido
  }

  //Map dos pedidos do user
  Order.fromDocuments(DocumentSnapshot doc){
    orderId = doc.documentID;
    items = (doc.data['items'] as List<dynamic>).map((e){
      return CartProduct.fromMap(e as Map<String,dynamic>);
    }).toList();
    price  = doc.data['price'] as num;
    userId = doc.data['user'] as String;
    address = Address.fromMap(doc.data['address'] as Map<String, dynamic>);
    date = doc.data['date'] as Timestamp;
    novaData = date.toDate();
    status = Status.values[doc.data['status'] as int];//Estado dos pedidos
  }

  String get formattedId => '#${orderId.padLeft(4,'0')}';
  String get statusText => getStatusText(status);

  //TODO: Salvar no firebase
  Future<void> save()async{
    firestore.collection('orders').document(orderId).setData(
      {
        'items': items.map((e) => e.toOrderItemMap()).toList(),
        'price': price,
        'user': userId,
        'address': address.toMap(),
        'status': status.index,
        'date': Timestamp.now(),
      }
    );
  }

  Function() get back{
    return status.index >= Status.transporting.index ?
    (){
      status = Status.values[status.index - 1];
      firestoreRef.updateData(
        {'status' : status.index}
      );
    }:null;
  }

  Function() get advance{
    return status.index <= Status.transporting.index ?
        (){
          status = Status.values[status.index + 1];
          firestoreRef.updateData(
              {'status' : status.index}
          );
    }:null;
  }

  void cancel(){
    status = Status.canceled;
    firestoreRef.updateData(
        {'status' : status.index}
    );
  }

  static String getStatusText(Status status){
    switch(status){
      case Status.canceled:
        return 'Cancelado';
      case Status.preparing:
        return 'Preparação';
      case Status.transporting:
        return 'Em transporte';
      case Status.delivered:
        return 'Entregue';
      default:
        return '';

    }
}
  void updateFromDocument(DocumentSnapshot doc){
    status = Status.values[doc.data['status'] as int];//Estado dos pedidos
  }

  @override
  String toString() {
    return 'Order{orderId: $orderId, items: $items, price: $price, userId: $userId, address: $address, date: $date, firestore: $firestore}';
  }


}