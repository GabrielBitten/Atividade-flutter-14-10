import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaTransacoes extends StatefulWidget {
  @override
  _ListaTransacoesState createState() => _ListaTransacoesState();
}

class _ListaTransacoesState extends State<ListaTransacoes> {
  List<dynamic> transacoes = [];

  Future<void> fetchTransacoes() async {
    final url = 'http://localhost:3000';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        transacoes = List<Map<String, dynamic>>.from(
          (response.body as List).map((item) => item as Map<String, dynamic>),
        );
        setState(() {});
      }
    } catch (e) {
      print('Erro na requisição: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTransacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Transações',
          style: TextStyle(
            color: Colors.white,      
            fontWeight: FontWeight.bold, 
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: transacoes.length,
        itemBuilder: (context, index) {
          final transacao = transacoes[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(transacao['id'].toString()),
            ),
            title: Text(transacao['nome']),
            subtitle: Text('Valor: R\$ ${transacao['valor']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
       
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
