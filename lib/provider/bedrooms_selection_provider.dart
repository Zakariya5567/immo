import 'package:flutter/material.dart';

class BedRoomBathRoomSelectionProvider extends ChangeNotifier {
  int bedRoomIndex = -1;

  setBedRoomCurrentIndex(int index) {
    bedRoomIndex = index;
    debugPrint('$bedRoomIndex');
    notifyListeners();
  }

  bool isBedroomSelected(int index, int totalItems) {
    return index == bedRoomIndex && totalItems > 6;
  }

  int bathRoomIndex = -1;

  setBathRoomCurrentIndex(int index) {
    bathRoomIndex = index;
    debugPrint('$bathRoomIndex');
    notifyListeners();
  }

  bool isBathroomSelected(int index, int totalItems) {
    return index == bathRoomIndex && totalItems <= 6;
  }
}
