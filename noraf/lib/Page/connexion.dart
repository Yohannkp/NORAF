import 'package:flutter/material.dart';
import 'package:noraf/Page/Form.dart';
import 'package:noraf/Repository/AuthentificationService.dart';

import 'Splashscreen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = true;
  String error = "";
  // Variables pour stocker les valeurs du formulaire
  String _email = '';
  String _motDePasse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire de Connexion'),
      ),
      body: loading ? Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer une adresse email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mot de passe'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
                onSaved: (value) {
                  _motDePasse = value!;
                },
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              Text("$error",style: TextStyle(color: Colors.red),),
              ElevatedButton(
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    // Faire quelque chose avec les valeurs du formulaire
                    // Par exemple, envoyer une requête HTTP pour vérifier les informations de connexion
                    print('Email: $_email');
                    print('Mot de passe: $_motDePasse');
                    AuthentificationService _authService = new AuthentificationService();
                    final request = await _authService.signInWithEmailAndPassword("$_email", "$_motDePasse");
                    setState(() {
                      loading = false;
                    });

                    if(request == null){
                      print("Erreur lors de la connexion");
                      setState(() {
                        loading = true;
                        error = "Erreur lors de la connexion";
                      });
                    }
                    }
                },

                child: Text('Se connecter'),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UserForm()));
              }, child: Text("Inscription"))
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginForm(),
  ));
}
