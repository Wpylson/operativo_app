import 'package:flutter/cupertino.dart';

class PageManager{

  PageManager(this._pageController);
 final PageController _pageController;

  int page = 0;

  //trocar de pagina
  void setPage(int value){
    if(value == page) return;//impedir que vá para page que eu já estou.
    page = value;
    _pageController.jumpToPage(value);
  }
}