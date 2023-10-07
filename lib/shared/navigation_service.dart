// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';

// ignore: library_private_types_in_public_api
_NavigationService navigationService = _NavigationService.instance;

class _NavigationService {
  _NavigationService._();
  
  static final _NavigationService instance = _NavigationService._();
  
  final ValueNotifier<int> navigationValue = ValueNotifier(0);

  set setNavigation(int num) => {
        navigationValue.value = num,
      };

  int get getNavigation => navigationValue.value;
}
