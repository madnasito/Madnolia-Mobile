import 'package:flutter/material.dart';
import 'package:madnolia/widgets/app_page.dart';

// EJEMPLO 1: Página estándar con drawer y todo el layout
class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        children: [
          Text('Esta es una página con todo el layout por defecto'),
          // Tu contenido aquí
        ],
      ),
    );
  }
}

// EJEMPLO 2: Página sin drawer
class ExamplePageNoDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageWithoutDrawer(
      title: "Mi Página",
      child: Column(
        children: [
          Text('Esta página no tiene drawer'),
          // Tu contenido aquí
        ],
      ),
    );
  }
}

// EJEMPLO 3: Página con título personalizado y acciones
class ExamplePageCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "Configuración",
      appBarActions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Acción personalizada
          },
        ),
        IconButton(
          icon: Icon(Icons.help),
          onPressed: () {
            // Otra acción
          },
        ),
      ],
      child: Column(
        children: [
          Text('Página con título y acciones personalizadas'),
          // Tu contenido aquí
        ],
      ),
    );
  }
}

// EJEMPLO 4: Página de pantalla completa
class ExampleFullScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageFullScreen(
      child: Column(
        children: [
          Text('Página en pantalla completa'),
          // Tu contenido aquí
        ],
      ),
    );
  }
}

// EJEMPLO 5: Página solo con contenido mínimo
class ExampleMinimalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPageMinimal(
      child: Column(
        children: [
          Text('Página con layout mínimo'),
          // Tu contenido aquí
        ],
      ),
    );
  }
}

// EJEMPLO 6: Conversión de tu CustomScaffold actual
class ExampleConvertedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // En lugar de:
    // return CustomScaffold(
    //   body: tu_contenido
    // );
    
    // Ahora simplemente usas:
    return AppPage(
      child: Column(
        children: [
          Text('Tu contenido aquí'),
          // Todo tu contenido anterior va aquí
        ],
      ),
    );
  }
}
