import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/producto_detail_screen.dart';
import '../screens/categorias_screen.dart';
import '../screens/proveedores_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  'login': (_) => const LoginScreen(),
  'register': (_) => const RegisterUserScreen(),
  'home': (_) => const HomeScreen(),
  'detalle': (_) => const DetailProductScreen(),
  'categorias': (_) => const CategoriasScreen(),
  'proveedores': (context) => const ProveedoresScreen(),
};
