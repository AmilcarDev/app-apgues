import 'package:flutter/material.dart';
import 'package:pgues_app/Utils/color_loader_5.dart';
import 'package:pgues_app/Utils/globals_functions.dart';
import 'package:pgues_app/services/api_service.dart';
import 'package:pgues_app/services/databse_service.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _phone;
  TextEditingController _controllerEmail, _controllerPhone;

  ApiService api;
  bool _isLoading;
  BuildContext _ctx;
  _UpdateProfilePageState() {
    _controllerEmail = TextEditingController();
    _controllerPhone = TextEditingController();
    api = new ApiService();
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _controllerEmail.text = data.user.email;
    _controllerPhone.text = data.person.phone;
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Actualizacion de Datos",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: barColor,
        centerTitle: true,
        actions: <Widget>[],
        elevation: 0.0,
      ),
      body: new SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 50.0, left: 24.0, right: 24.0),
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("UpdateProfile 1"),
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (val) =>
                          val.length < 1 ? 'El email es requerido' : null,
                      onSaved: (val) => _email = val,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: _controllerEmail,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Telefono'),
                      validator: (val) =>
                          val.length < 1 ? 'El telefono es requerido' : null,
                      onSaved: (val) => _phone = val,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      controller: _controllerPhone,
                      autocorrect: false,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: _isLoading
                          ? new ColorLoader5()
                          : RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              onPressed: _submit,
                              padding: EdgeInsets.all(12),
                              color: Colors.lightBlueAccent,
                              child: Text('Actualizar Datos',
                                  style: TextStyle(color: Colors.white)),
                            ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submit() async {
    final form = formKey.currentState;
     var db = new DatabaseService();
    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
     await api.updateData(data.user.apiToken, _email, _phone);
      await db.updatePerson(data.person);
      await db.updateUser(data.user);
       Navigator.of(_ctx).pop();
       Navigator.of(_ctx).pushReplacementNamed("/profile");
    }
    setState(() => _isLoading = false);
  }
}
