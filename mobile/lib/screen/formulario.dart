
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Formulario extends StatefulWidget {
  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController valorController = TextEditingController();

  Future<void> adicionarTransacao() async {
    const url = 'http://localhost:3000/transacoes';
    final nome = nomeController.text;
    final valor = valorController.text;

    if (nome.isNotEmpty && valor.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode({
            'nome': nome,
            'valor': valor,
          }),
          headers: {
            'Content-Type': 'application/json', // Cabeçalho para JSON
          },
        );

        if (response.statusCode == 201) {
          // Mensagem de sucesso
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transação adicionada com sucesso!')),
          );
          // Limpar os campos após a adição
          nomeController.clear();
          valorController.clear();
          Navigator.pop(context);
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
        title: const Text(
          'Adicionar Transação',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o valor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await adicionarTransacao();
                  }
                },
                child: const Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
