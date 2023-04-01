import 'package:example/providers/change_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _buttonLabels = ['Button 1', 'Button 2', 'Button 3'];

  bool _isPressed = false;

  void _addButton() {
    setState(() {
      _buttonLabels.add('Button ${_buttonLabels.length + 1}');
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de contraseñas'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Notificaciones',
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text('BULLMARKET PASSWORD GESTOR'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Usuario'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Aspecto'),
              onTap: () {
                theme.getTheme() == ThemeData.dark()
                    ? theme.setTheme(ThemeData.light())
                    : theme.setTheme(ThemeData.dark());
              },
            ),
            ListTile(
              title: const Text('Gestionar cuentas'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Revisar todas las cuentas'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Configuración'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Cambiar usuario'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Cerrar sesión'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Salir'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _buttonLabels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _isPressed = _isPressed ? false : true;
                    _verCuenta(context, _buttonLabels[index]);
                    print(_buttonLabels[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(375, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: _isPressed
                          ? BorderRadius.circular(10.0)
                          : BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Cuenta $index',
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formAgregarCuenta(
              context); ////// CHEQUEAR QUE SE HAYA MANDADO TODO OK ANTES DE AÑADIR EL BOTON
          _addButton();
        },
        tooltip: 'Añadir cuenta',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _formAgregarCuenta(BuildContext context) {
  TextEditingController nombreCuenta = TextEditingController();
  TextEditingController nombreUser = TextEditingController();
  TextEditingController pass = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Añadir cuenta"),
        content: const Text("¿Desea añadir una nueva cuenta?"),
        actions: <Widget>[
          //textoformulario
          TextFormField(
            controller: nombreCuenta,
            decoration: const InputDecoration(
              hintText: 'Servicio (ej. Facebook, Instagram, etc.)',
            ),
        
          ),

          TextFormField(
            controller: nombreUser,
            decoration: const InputDecoration(
              hintText: 'Usuario/Correo',
            ),
            onSaved: (value) {},
          ),
          TextFormField(
            controller: pass,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Contraseña',
            ),
            onSaved: (value) {},
          ),

          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _verCuenta(BuildContext context, String nombreCuenta) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("nombreCuenta"),
        content: const Text("¿Desea añadir una nueva cuenta?"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(60, 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text('Mostrar contraseña'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Revisar todo'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Cambiar contraseña'),
          ),
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
