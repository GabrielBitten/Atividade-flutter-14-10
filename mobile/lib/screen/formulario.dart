import 'package:flutter/material.dart';

class FormularioItem extends StatefulWidget {
  @override
  _FormularioItemState createState() => _FormularioItemState();
}

class _FormularioItemState extends State<FormularioItem> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  void _adicionarItem() {
    final nome = _nomeController.text;
    final valor = double.tryParse(_valorController.text) ?? 0.0;

    if (nome.isNotEmpty && valor > 0) {
      // Aqui você pode adicionar o código para salvar os dados no seu banco
      Navigator.pop(context); // Volta para a tela anterior
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Por favor, preencha todos os campos corretamente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Item'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarItem,
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
