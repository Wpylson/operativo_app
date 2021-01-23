import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/estabelecimentos.dart';

class EstabelecimentosManager extends ChangeNotifier{

  EstabelecimentosManager(){
    _loadAllEstabelecimentos();
  }
  
  final Firestore firestore = Firestore.instance;
  List<Estabelecimentos> allEstabelecimentos =[];
  
  //Para pesquisar
  String _search ='';
  String get search => _search;
  set search(String value){
    _search = value;
    notifyListeners();
  }

  //Filtrar para pesquisa
  List<Estabelecimentos> get filteredEstabs{
    final List<Estabelecimentos> filteredEstab =[];

    if(search.isEmpty){
      filteredEstab.addAll(allEstabelecimentos);
    }else{
      filteredEstab.addAll(allEstabelecimentos.where(
              (estab) => estab.name.toLowerCase().contains(search.toLowerCase())
      )
      );
    }

    return filteredEstab;
  }
  
  Future<void> _loadAllEstabelecimentos()async{
    final QuerySnapshot snapshot = await firestore.collection('citys')
        .document('namibe').collection('categorys').getDocuments();

    allEstabelecimentos = snapshot.documents.map((e) => Estabelecimentos.fromDocument(e)).toList();
    notifyListeners();
  }

}