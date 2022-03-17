import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:noshup_admin/model/user.dart';

class AuthNotifier extends ChangeNotifier {
  Users? _user;

  Users? get user {
    return _user;
  }

  void setUser(Users user) {
    _user = user;
    notifyListeners();
  }

  // Test
  Users? _userDetails;

  Users? get userDetails => _userDetails;

  setUserDetails(Users user) {
    _userDetails = user;
    notifyListeners();
  }
}
