import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'formulario.dart';

class ListaTransacoes extends StatefulWidget {
  @override
  _ListaTransacoesState createState() => _ListaTransacoesState();
}

class _ListaTransacoesState extends State<ListaTransacoes> {
  List<dynamic> transacoes = [];

  Future<void> fetchTransacoes() async {
    const url = 'http://localhost:3000/transacoes';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        transacoes = data['transacoes'];
      });
    } else {
      print('Erro ao carregar dados: ${response.statusCode}');
    }
  }

  Future<void> deleteTransacao(int id) async {
    final url = 'http://localhost:3000/transacoes/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      fetchTransacoes(); 
    } else {
      print('Erro ao excluir: ${response.statusCode}');
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                  
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Formulario(transacao: transacao),
                      ),
                    ).then((_) {
                      fetchTransacoes(); 
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                 
                    deleteTransacao(transacao['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Formulario()),
          ).then((_) {
            fetchTransacoes(); 
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
