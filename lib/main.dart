import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/producto_provider.dart';
import 'services/auth_service.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'providers/categoria_provider.dart';
import 'providers/proveedor_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CategoriaProvider()),
        ChangeNotifierProvider(create: (_) => ProveedorProvider()),

        // Agregamos aquí si tenemos otros provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Librería Flutter',
      theme: AppTheme.lightTheme,
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}
