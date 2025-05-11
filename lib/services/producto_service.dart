import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/producto_model.dart';

class ProductService {
  final String _baseUrl = "143.198.118.203:8100";
  final String _user = "test";
  final String _pass = "test2023";

  List<ProductItem> products = [];

  ProductService() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      products = await cargarProductos();
    } catch (e) {
      print('Error al cargar productos desde loadProducts(): $e');
    }
  }

  //  Listar productos
  Future<List<ProductItem>> cargarProductos() async {
    final uri = Uri.http(_baseUrl, '/ejemplos/product_list_rest/');
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.get(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final List<dynamic> listado = decoded['Listado'];
      return listado.map((json) => ProductItem.fromMap(json)).toList();
    } else {
      throw Exception(
        'Error al cargar productos: ${response.statusCode} - ${response.body}',
      );
    }
  }

  //  Agregar producto
  Future<void> agregarProducto(ProductItem producto) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/product_add_rest/');
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_name': producto.productName,
        'product_price': producto.productPrice,
        'product_image': producto.productImage,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error al agregar producto: ${response.statusCode} - ${response.body}',
      );
    }
  }

  // Eliminar producto
  Future<void> eliminarProducto(int id) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/product_del_rest/');
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: jsonEncode({'product_id': id}),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error al eliminar producto: ${response.statusCode} - ${response.body}',
      );
    }
  }

  //  Editar producto
  Future<void> editarProducto(ProductItem producto) async {
    final uri = Uri.http(_baseUrl, '/ejemplos/product_edit_rest/');
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';

    final response = await http.post(
      uri,
      headers: {'Authorization': basicAuth, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_id': producto.productId,
        'product_name': producto.productName,
        'product_price': producto.productPrice,
        'product_image': producto.productImage,
        'product_state': producto.productState,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Error al editar producto: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
