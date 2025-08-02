# Sistema de Layout Mejorado

Este sistema reemplaza el uso repetitivo de `CustomScaffold` con un sistema más flexible y reutilizable.

## Archivos creados:

1. **`base_layout.dart`** - Layout base con todas las configuraciones
2. **`app_page.dart`** - Widgets de página pre-configurados
3. **`examples/page_examples.dart`** - Ejemplos de uso

## Migración desde CustomScaffold

### Antes:
```dart
class MiPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Text('Mi contenido'),
        ],
      ),
    );
  }
}
```

### Después:
```dart
import 'package:madnolia/widgets/app_page.dart';

class MiPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        children: [
          Text('Mi contenido'),
        ],
      ),
    );
  }
}
```

## Tipos de páginas disponibles:

### 1. AppPage - Página estándar (reemplaza CustomScaffold)
```dart
AppPage(
  child: tu_contenido,
  title: "Título opcional",
  appBarActions: [...], // Acciones opcionales
  showDrawer: true,     // Por defecto
  showAppBar: true,     // Por defecto
  showBackground: true, // Por defecto
  showSafeArea: true,   // Por defecto
)
```

### 2. AppPageWithDrawer - Página con drawer (comportamiento estándar)
```dart
AppPageWithDrawer(
  child: tu_contenido,
  title: "Mi Página",
)
```

### 3. AppPageWithoutDrawer - Página sin drawer
```dart
AppPageWithoutDrawer(
  child: tu_contenido,
  title: "Página Sin Menu",
)
```

### 4. AppPageFullScreen - Pantalla completa
```dart
AppPageFullScreen(
  child: tu_contenido,
)
```

### 5. AppPageMinimal - Layout mínimo
```dart
AppPageMinimal(
  child: tu_contenido,
)
```

## Ventajas del nuevo sistema:

1. **Menos código repetitivo** - No más imports de CustomScaffold en cada página
2. **Mayor flexibilidad** - Puedes controlar qué elementos mostrar
3. **Mejor organización** - Cada tipo de página tiene su propósito específico
4. **Fácil mantenimiento** - Cambios en el layout se hacen en un solo archivo
5. **Consistencia** - Todas las páginas siguen el mismo patrón

## Pasos para migrar:

1. Importa `package:madnolia/widgets/app_page.dart` en lugar de `custom_scaffold.dart`
2. Cambia `CustomScaffold(body: ...)` por `AppPage(child: ...)`
3. Si necesitas personalizaciones, usa los parámetros disponibles
4. Para casos específicos, usa las variaciones pre-definidas

## Personalización avanzada:

Si necesitas algo muy específico, puedes usar `BaseLayout` directamente:

```dart
import 'package:madnolia/widgets/base_layout.dart';

BaseLayout(
  showDrawer: false,
  showAppBar: true,
  showBackground: false,
  showSafeArea: true,
  title: "Título personalizado",
  actions: [
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
  child: tu_contenido,
)
```

## Mantenimiento:

- Para cambiar el drawer: edita `BaseLayout._buildDrawer()`
- Para cambiar el appBar: edita `BaseLayout._buildAppBar()` 
- Para añadir nuevos tipos de página: crea nuevas clases en `app_page.dart`
