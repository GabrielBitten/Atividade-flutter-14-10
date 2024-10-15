import 'package:http/http.dart' as http;

abstract class AbstractApi {
  final String _urlLocalHost = 'http://localhost:3000';
  final String _recurso;

  AbstractApi(this._recurso);

  Future<String?> getAll() async {
    var response = await http.get(Uri.parse('$_urlLocalHost/$_recurso'));
    return response.body;
  }

  Future<String?> getById(int id) async {
    var response = await http.get(Uri.parse('$_urlLocalHost/$_recurso/$id'));
    return response.body;
  }

  Future<String?> post(Map<String, dynamic> dados) async {
    var response = await http.post(
      Uri.parse('$_urlLocalHost/$_recurso'),
      body: dados,
    );
    return response.body;
  }

  Future<String?> updateById(int id, Map<String, String> dados) async {
    var response = await http.put(
      Uri.parse('$_urlLocalHost/$_recurso/$id'),
      body: dados,
    );
    return response.body;
  }

  Future<String?> deleteById(int id) async {
    var response = await http.delete(Uri.parse('$_urlLocalHost/$_recurso/$id'));
    return response.statusCode == 200 ? 'Item com id $id deletado.' : null;
  }
}
