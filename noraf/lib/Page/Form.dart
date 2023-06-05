import 'package:flutter/material.dart';
import 'package:noraf/Model/Personne.dart';
import 'package:noraf/Page/Splashscreen.dart';
import 'package:noraf/Page/connexion.dart';
import 'package:noraf/Repository/AuthentificationService.dart';
import 'package:noraf/Repository/PersonneRepository.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  // Variables pour stocker les valeurs du formulaire
  String _nom = '';
  String _prenom = '';
  String _email = '';
  String _motDePasse = '';
  String _sexe = '';
  String _adresse = '';
  String _numeroTelephone = '';
  DateTime _dateNaissance = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire Utilisateur'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nom = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _prenom = value!;
                },
              ),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Sexe'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un sexe';
                  }
                  return null;
                },
                onSaved: (value) {
                  _sexe = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer une adresse';
                  }
                  return null;
                },
                onSaved: (value) {
                  _adresse = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Numéro de téléphone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un numéro de téléphone';
                  }
                  return null;
                },
                onSaved: (value) {
                  _numeroTelephone = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date de naissance'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer une date de naissance';
                  }
                  return null;
                },
                onTap: () async {
                  final DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _dateNaissance = selectedDate;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(
                    text: _dateNaissance.toString().split(' ')[0]),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    // Faire quelque chose avec les valeurs du formulaire
                    // Par exemple, envoyer une requête HTTP pour enregistrer les données
                    print('Nom: $_nom');
                    print('Prénom: $_prenom');
                    print('Email: $_email');
                    print('Mot de passe: $_motDePasse');
                    print('Sexe: $_sexe');
                    print('Adresse: $_adresse');
                    print('Numéro de téléphone: $_numeroTelephone');
                    print('Date de naissance: $_dateNaissance');
                    Personne p = new Personne(role: "user", uid: "uid", id_user: "id_user", nom: "$_nom", prenom: "$_prenom", address: "$_adresse", numero_telephone: "$_numeroTelephone", email: "$_email", motdepass: "$_motDePasse", sexe: "$_sexe", date_naissance: "$_dateNaissance");
                    AuthentificationService _auth = new AuthentificationService();
                    _auth.registerInWithEmailAndPassword(p.email, p.motdepass,p);
                    PersonneRepository _perseonnerep = new PersonneRepository();

                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Splashscreen()));
                  }
                },
                child: Text('Valider'),
              ),
              ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginForm()));}, child: Text("Connexion"))
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserForm(),
  ));
}
