import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:operativo_final_cliente/models/address.dart';
import 'package:operativo_final_cliente/models/cart_product.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:operativo_final_cliente/models/user.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/services/cepaberto_service.dart';

class CartManager extends ChangeNotifier{

  List<CartProduct> items =[];
  User user;
  Address address;
  num productPrice = 0.0;
  num deliveryPrice;

  num get totalPrice => productPrice + (deliveryPrice ?? 0);

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  final Firestore firestore = Firestore.instance;

  // ignore: avoid_void_async
  void updateUser(UserManager userManager)async{//Para pegar o cart list do user logado se estiver ou não logado
    user = userManager.user;
    productPrice = 0.0;
    items.clear();//limpar os items do carrinho caso o user seja outro
    removeAddress();//remove o address para qndo outro user logar nao der problema

    if(user != null){
     await _loadCartItems();
      _loadUserAddress();
    }
  }

  //Carregar o carrinho do user
  Future<void> _loadCartItems()async{
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    items = cartSnap.documents.map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)
    ).toList();
  }

  //Carregar o endereco do user caso já tenha para calcular a distancia
  Future<void> _loadUserAddress()async{
    if(user.address != null &&
        await calculateDelivery(user.address.lat, user.address.long)){
      address =user.address;
      notifyListeners();
    }
  }


  //add product ao carrinho
  void addToCart(Product product){
    //Procurar item ja existente no cart, se ja existe incrementar a quantidade  e nao add um novo produto
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();//incrementar a quantidade
    }catch (e){
      final cartProduct = CartProduct.froProduct(product);
      //actualizar  o produto no carrinho
      cartProduct.addListener(_onItemUpdated);//No cart qndo chamarem o addListener irá accionar o método onItemUpdated()
      items.add(cartProduct);
      //Salvar o item no carrinho
      user.cartReference.add(cartProduct.toCartItemMap())
      .then((doc) => cartProduct.id = doc.documentID);
      _onItemUpdated();
    }

    notifyListeners();

  }

  //editar  o produto no carrinho(update e remove)
  void _onItemUpdated(){
    productPrice = 0.0;//preço total

    for(int i = 0; i < items.length; i++){
      final cartProduct = items[i];

      if(cartProduct.quantity == 0){
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }

    notifyListeners();
  }

  void _updateCartProduct(CartProduct cartProduct){
    if(cartProduct.id != null){
      user.cartReference.document(cartProduct.id)
          .updateData(cartProduct.toCartItemMap());
    }
  }

  void removeOfCart(CartProduct cartProduct){
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  //Validação do cart
  bool get isCartValid{
    for(final cartProduct in items){
      if(!cartProduct.hasStock) return false;
    }
    return true;
  }

  //se o endereco for direnete nulo e preco de entrega estiver calculado vou retornar isAddressValid
  bool get isAddressValid => address != null &&  deliveryPrice !=null;

  //Pegar o Address
  Future<void> getAddress(String cep)async{
    loading = true;
    final cepAbertoService = CepAbertoService();

    try {
      final cepAbertoAddress = await cepAbertoService.getAddressFromCep(cep);

      if(cepAbertoAddress != null){
         address = Address(
          street: cepAbertoAddress.logradouro,
          district: cepAbertoAddress.bairro,
          zipCode: cepAbertoAddress.cep,
          city: cepAbertoAddress.cidade.nome,
          state: cepAbertoAddress.estado.sigla,
          lat: cepAbertoAddress.longitude,
          long: cepAbertoAddress.longitude
        );
      }

      loading = false;
    }catch(e){
      loading = false;
      Future.error('CEP Inválido');
    }
  }

//Para deixar o address null para voltar na colocar o endereco
  void removeAddress(){
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  Future<void> setAddress(Address address) async {
    loading = true;
    this.address = address;

    if(await calculateDelivery(address.lat, address.long)){
      user.setAddress(address);
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }


    Future<bool> calculateDelivery(double lat, double long) async {
      final DocumentSnapshot doc = await firestore.document('aux/delivery').get();

      final latStore = doc.data['lat'] as double;
      final longStore = doc.data['long'] as double;

      final base = doc.data['base'] as num;
      final km = doc.data['km'] as num;
      final maxkm = doc.data['maxkm'] as num;

     //double dis = await Geolocator().distanceBetween(latStore, longStore, lat, long);

      //dis /= 1000.0;
      const double dis =2.6799090;

    debugPrint('Distances $dis');
      debugPrint('lat cliente $lat');
      debugPrint('long cliente $long');
      debugPrint('lat store $latStore');
      debugPrint('long store $longStore');

    if(dis > maxkm){
      return false;
    }

    //TODO: CALCULO DA TAXA DE ENTREGA
    deliveryPrice = base + dis * km;
    return true;
  }

  //Limpar os dados que estao no carrinho
  void clear(){
    for(final cartProduct in items){
      user.cartReference.document(cartProduct.id).delete();
    }
    items.clear();
    notifyListeners();
  }


}