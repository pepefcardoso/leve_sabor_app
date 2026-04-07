import 'package:flutter/cupertino.dart';

class FavoritePostButtonController extends ChangeNotifier {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  set isFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
    notifyListeners();
  }
}
