import 'package:flutter/cupertino.dart';
import 'package:nf_tugas_public_api/services/api_repository.dart';

import '../models/user.dart';

enum ResultState { loading, hasData, error, empty }

class ApiProvider extends ChangeNotifier {
  ApiProvider() {
    fetchUser();
  }
  ApiRepository apiRepository = ApiRepository();
  late User _user;
  User get user => _user;

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  fetchUser() async {
    _state = ResultState.loading;
    notifyListeners();
    final result = await apiRepository.getUser();
    if (result.runtimeType == User) {
      _state = ResultState.hasData;
      notifyListeners();
      _user = result;
    } else {
      _state = ResultState.error;
      notifyListeners();
    }
  }
}
