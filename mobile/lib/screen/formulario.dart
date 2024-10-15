// formulario.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Formulario extends StatefulWidget {
  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<Formulario> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController valorController = TextEditingController();

  Future<void> adicionarTransacao() async {
    final url = 'http://localhost:3000'; // Substitua pelo IP do seu PC
    final nome = nomeController.text;
    final valor = valorController.text;

    if (nome.isNotEmpty && valor.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode({
            'nome': nome,
            'valor': double.parse(valor),
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 201) {
          Navigator.pop(context); // Voltar à lista após adicionar
        } else {
          print('Erro ao adicionar: ${response.statusCode}');
        }
      } catch (e) {
        print('Erro ao adicionar: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar transação',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            
          ),
          ), centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: adicionarTransacao,
              child: const Text('Adicionar',
                style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
             fontSize: 18,
          ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
