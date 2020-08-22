import 'package:flutter/material.dart';

class PageManager {
  final PageController _pageController;

  PageManager(this._pageController);

  int currentPage = 0;

  void setPage(int page){
    if(page == currentPage){
      return;
    }
    currentPage = page;
    _pageController.jumpToPage(page);
  }
}
