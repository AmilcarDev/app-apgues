import 'package:pgues_app/models/data_model.dart';
import 'package:pgues_app/services/api_service.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(AppModel appModel);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  ApiService api = new ApiService();
  LoginScreenPresenter(this._view);

  doLogin(String username, String password) {
    api.login(username, password).then((AppModel appModel) {
      _view.onLoginSuccess(appModel);
    }).catchError((error) {
      _view.onLoginError(error.toString());
    });
  }
}
