
import 'package:flutter/material.dart';

import '../Data/models/MyUser.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser ;
  void updateUser (MyUser newUser){
    currentUser=newUser;
    notifyListeners();

  }
}