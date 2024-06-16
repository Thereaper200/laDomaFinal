import 'package:flutter/material.dart';
import 'package:examendesarrollomovil/models/personaModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Personas extends StatefulWidget {
  const Personas({super.key});

  @override
  State<Personas> createState() => _PersonasState();
}

class _PersonasState extends State<Personas> {
  Results? user;

  @override
  void initState() {
    super.initState();
    fetchUser(); // Llamar a la función para consumir la API al iniciar
  }

  Future<void> fetchUser() async {
    try {
      final response = await http.get(Uri.parse("https://randomuser.me/api/"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          user = Model.fromJson(data).results[0];
        });
        print('URL de la imagen: ${user!.picture.large}'); // Asegurarnos de que la URL es correcta
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen.shade300,
        title: Text("LA DOMA FINAL",style: TextStyle(
          color: Colors.white,
        ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightGreen.shade300,
              Colors.lightGreen.shade700,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: user == null
              ? Center(child: CircularProgressIndicator())
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                user!.picture.large.isNotEmpty
                    ? FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png', // Un placeholder que deberías tener en tu carpeta assets
                  image: user!.picture.large,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Text("Calale otra vez carnal o mas al rato"); // Icono de error si no se puede cargar la imagen
                  },
                )
                    : Icon(Icons.error), // Icono de error si la URL está vacía
                SizedBox(height: 20),
                Text(
                  '${user!.name.first} ${user!.name.last}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // Alinear el texto al centro
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: fetchUser,
                  child: Text('Actualizar Usuario'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
