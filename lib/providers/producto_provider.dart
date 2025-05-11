import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../services/producto_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  List<ProductItem> _products = [];
  List<ProductItem> _filteredProducts = [];

  List<ProductItem> get products => _filteredProducts;

  ProductProvider() {
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    try {
      _products = await _productService.cargarProductos();
      _filteredProducts = _products;
      notifyListeners();
    } catch (e) {
      print('Error cargando productos: $e');
    }
  }

  Future<void> agregarProducto(ProductItem producto) async {
    try {
      await _productService.agregarProducto(producto);
      await cargarProductos();
    } catch (e) {
      print('Error al agregar producto: $e');
    }
  }

  Future<void> eliminarProducto(int id) async {
    try {
      await _productService.eliminarProducto(id);
      await cargarProductos();
    } catch (e) {
      print('Error al eliminar producto: $e');
    }
  }

  Future<void> editarProducto(ProductItem producto) async {
    try {
      await _productService.editarProducto(producto);
      await cargarProductos();
    } catch (e) {
      print('Error al editar producto: $e');
    }
  }
}
