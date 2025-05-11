import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categoria_model.dart';

class CategoriaService {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<CategoriaItem> categorias = [];

  Future<void> loadCategorias() async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_list_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.get(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('📦 Respuesta categorías: $data');
      final listado = (data['Listado Categorias'] ?? []) as List;
      categorias = listado.map((json) => CategoriaItem.fromMap(json)).toList();
    } else {
      throw Exception('Error al cargar categorías');
    }
  }

  Future<void> agregarCategoria(CategoriaItem categoria) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_add_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: json.encode({
        'category_name': categoria.categoryName,
        'category_state': categoria.categoryState,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar categoría');
    }
  }

  Future<void> editarCategoria(CategoriaItem categoria) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_edit_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: json.encode({
        'category_id': categoria.categoryId,
        'category_name': categoria.categoryName,
        'category_state': categoria.categoryState,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al editar categoría');
    }
  }

  Future<void> eliminarCategoria(int id) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/category_del_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: json.encode({'category_id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar categoría');
    }
  }
}
