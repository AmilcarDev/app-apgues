import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/color_loader_5.dart';
import 'package:pgues_app/models/data_model.dart';
import 'package:pgues_app/pages/login/login_screen_presenter.dart';
import 'package:pgues_app/services/auth_service.dart';
import 'package:pgues_app/services/databse_service.dart';
import 'package:pgues_app/Utils/globals_functions.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    implements LoginScreenContract, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  TextEditingController _controllerUsername, _controllerPassword;

  LoginScreenPresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
    _controllerUsername = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  void dispose() {
    super.dispose();

    Navigator.of(_ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 64.0,
                child: Image.asset('assets/minerva.png'),
              ),
            ),
            new Text(
              "APGUES",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48.0),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Carnet'),
                      validator: (val) =>
                          val.length < 1 ? 'El carnet es requerido' : null,
                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      controller: _controllerUsername,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (val) =>
                          val.length < 1 ? 'El Password es requerido' : null,
                      onSaved: (val) => _password = val,
                      obscureText: true,
                      controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: _submit,
                        padding: EdgeInsets.all(12),
                        color: Colors.lightBlueAccent,
                        child: _isLoading
                            ? new ColorLoader5()
                            : Text('Iniciar Sesion',
                                style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.center,
                height: 75.0,
                width: double.infinity,
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Universidad de El Salvador',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '© Copyright 2019',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black26),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future onAuthStateChanged(AuthState state) async {
    if (state == AuthState.LOGGED_IN) {
      getAllData();
      getPeriodData();
      Navigator.of(_ctx).pushReplacementNamed("/home");
    }
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(AppModel appModel) async {
    var db = new DatabaseService();
    // print(appModel.period.stages);
    await db.saveUser(appModel.user);
    await db.saveStudent(appModel.student);
    await db.savePerson(appModel.person);
    // await db.savePeriod(appModel.period);
    // await db.saveStage(appModel.period.stages);
    _showSnackBar(appModel.user.toString());
    setState(() => _isLoading = false);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}
