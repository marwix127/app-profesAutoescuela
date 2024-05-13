# App profesores autónomos de autoescuela 👨🏻‍🏫🚙
Este es un proyecto en desarrollo para crear una app que facilite y ayude en la gestión de un profesor de autoescuela.

## Tecnologías 
- Esta aplicación se desarrolla en Flutter, un SDK para desarrollo de aplicaciones multiplataforma que utiliza el lenguaje Dart. Esta tecnología creada por Google se basa en widgets.
- Utiliza un sistema de autenticación y de base de datos implementado con Firebase, y una base de datos local SQL.

## Instalación del proyecto
### Descargas previas
  - Editor de código [VS Code](https://code.visualstudio.com/) (Recomendado)
  - [Flutter](https://docs.flutter.dev/get-started/install)
  - Emulador Android ([Android Studio](https://developer.android.com/studio?hl=es-419)) o IOS ([XCode](https://apps.apple.com/es/app/xcode/id497799835?mt=12))
  
### Instalaciones
#### Se recomienda seguir los pasos e instrucciones de la pagina oficial de Flutter para configurar correctamente el editor de código y los emuladores
- Al terminar la instalación de [Flutter](https://docs.flutter.dev/get-started/install) se aconseja ejecutar el comando "flutter doctor" para verificar que las instalaciones se han hecho correctamente.
- Para desarrollar [Flutter](https://docs.flutter.dev/get-started/install) en [VS Code](https://code.visualstudio.com/) vamos a necesitar almenos dos extensiones que son obligatorias: [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) y [Flutter (Extension)](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter). Estas se integran en el entorno de desarrollo.
- Estas extensiones son opcionales, pero pueden ser útiles en proyectos Flutter: [Lista Extensiones](#extensiones-de-vscode)
- Abrir el proyecto en VS Code
- Mediante la terminal ejecutar el comando "flutter pub get"
- Pulsar F1 y pulsar [Flutter:Select Device] y podremos seleccionar un dispositivo físico conectado o un dispositivo emulado que hayamos configurado. Ver [Ejecutar aplicación en Dispositivos](#ejecutar-aplicación-en-dispositivos)
- Ejecutar la aplicación con F5 o el comando "flutter run"

### Ejecutar aplicación en Dispositivos
## Dispositivos Android
 - Dispositivos Físicos: Conectar el dispositivo al ordenador y tener activada la depuración USB (Para activarlo por primera vez es necesario Activar las opciones de desarrollador)
 - Dispositivos virtuales: Mediante Android Studio, en las opciones de Virtual Device Manager, crear un dispositivo virtual con las características deseadas. (Se recomienda asignar 4GB RAM mínimo y ser todo lo generoso que se pueda con el espacio de almacenamiento). Si el dispositivo virtual esta corriendo, ya sera visible a la hora de seleccionar dispositivo.

## Dispositivos iOS
- Dispositivos Físicos: Conectar el dispositivo iOS al ordenador. Es necesario tener un Apple ID registrado y un dispositivo confiable. También, debes configurar el dispositivo para desarrollo en Xcode.
- Simuladores iOS: En Xcode, puedes seleccionar un simulador de iOS para ejecutar tu aplicación. Elige el simulador en la lista de dispositivos disponibles en Xcode. Asegúrate de que el simulador tenga las configuraciones adecuadas según tus necesidades (tamaño de pantalla, versión de iOS, etc.).

Ejecución: Una vez conectado el dispositivo físico o seleccionado el simulador, puedes ejecutar la aplicación desde VS Code seleccionando el dispositivo correspondiente. Usa el comando "flutter run" en la terminal o ejecuta la aplicación directamente desde VS Code.

### Extensiones de VSCode
- Activitus Bar
- Error Lens
- Paste JSON as Code
- Better Comments
- Terminal
- Awesome Flutter Snippets
- Bloc
- Dart Language
- Flutter Support
- Pubspec Assist
- Lorem ipsum
