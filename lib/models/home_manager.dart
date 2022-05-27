import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/section.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final List<Section> _sections = [];
  //Clone
  List<Section> _editingSections = [];
  bool loading = false;
  bool editing = false;

  Future<void> _loadSections() async {
    firestore.collection('home').orderBy('pos').snapshots().listen((snapshot) {
      _sections
          .clear(); //limpar os dados anteriores e trazer os dados actualizados do firebase
      for (final DocumentSnapshot document in snapshot.docs) {
        _sections.add(
          Section.fromDocument(document),
        ); //Add na List<Section> o dados do firebase para popular no Objecto Section
      }
      notifyListeners();
    });
  }

  List<Section> get sections {
    if (editing) {
      return _editingSections;
    } else {
      return _sections;
    }
  }

  //Entrar no modo de edicao
  void enterEditing() {
    editing = true;

    _editingSections = _sections.map((s) => s.clone()).toList();

    notifyListeners();
  }

  //Salavar edicao
  Future<void> saveEditing() async {
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) valid = false;
    }

    if (!valid) return;
    //TODO: SALVAMENTO
    loading = true;
    notifyListeners();

    //Posicao da sessao na tela
    int pos = 0;
    for (final section in _editingSections) {
      await section.save(pos);
      pos++;
    }

    //Verificar cada uma sessao para ser salva
    for (final section in List.from(_sections)) {
      if (!_editingSections.any((element) => element.id == section.id)) {
        await section.delete();
      }
    }

    loading = false;
    editing = false;
    notifyListeners();
  }

  //Descartar edicao
  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  //Criando uma noca sessao
  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  //Remover sessao
  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }
}
