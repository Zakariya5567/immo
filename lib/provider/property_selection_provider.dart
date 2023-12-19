import 'package:flutter/material.dart';

class PropertySelectionProvider extends ChangeNotifier {
  List propertyList = [];

  setPropertyCurrentIndex(int index) {
    propertyList.add(index);
    debugPrint('$propertyList');

    notifyListeners();
  }

  bool isPropertySelected(int index) {
    return propertyList.contains(index);
  }

  deSelectPropertyIndex(int index) {
    propertyList.removeWhere((element) => element == index);
    debugPrint('$propertyList');
    notifyListeners();
  }
}
