import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PageMixin extends ChangeNotifier {

  late PageController _pageController;
  PageController get pageController => _pageController;


  static BuildContext? _context;


  setPageController(PageController controller) => _pageController = controller;


  static PageMixin pageProvider(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<PageMixin>(context, listen: listen);
  }
}
