import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/proveedor_model.dart';

class ProveedorService {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ProveedorItem> proveedores = [];

  Future<void> loadProveedores() async {
    final uri = Uri.http(_baseUrl, '/ejemplos/provider_list_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.get(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final listado = (data['Proveedores Listado'] ?? []) as List;

      print(' Cantidad de proveedores recibidos: ${listado.length}');

      proveedores = listado.map((json) => ProveedorItem.fromMap(json)).toList();
    } else {
      throw Exception('Error al cargar proveedores');
    }
  }

  Future<void> agregarProveedor(ProveedorItem proveedor) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/provider_add_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: json.encode({
        'provider_name': proveedor.providerName,
        'provider_last_name': proveedor.providerLastName,
        'provider_mail': proveedor.providerMail,
        'provider_state': proveedor.providerState,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al agregar proveedor');
    }
  }

  Future<void> editarProveedor(ProveedorItem proveedor) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/provider_edit_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: json.encode({
        'provider_id': proveedor.providerId,
        'provider_name': proveedor.providerName,
        'provider_last_name': proveedor.providerLastName,
        'provider_mail': proveedor.providerMail,
        'provider_state': proveedor.providerState,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al editar proveedor');
    }
  }

  Future<void> eliminarProveedor(int id) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/provider_del_rest/');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: json.encode({'provider_id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar proveedor');
    }
  }
}
