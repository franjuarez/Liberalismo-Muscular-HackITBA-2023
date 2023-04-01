import 'dart:convert';
import 'dart:ui' as ui;
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
  final List<String> _buttonLabels = ['Twitter'];
  final Map<String, List> _buttonLabelsDIC = {
    'Twitter': ['imagen', 'Valen', '66666']
  };

  void _addButton(
      String sNombreCuenta, String imagen, String sNombreUser, String sPass) {
    setState(() {
      _buttonLabels.add(sNombreCuenta);
      _buttonLabelsDIC[sNombreCuenta] = [imagen, sNombreUser, sPass];
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
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://img.asmedia.epimg.net/resizer/GDyRMupWEAJLjimXNzJDVCAl2Yg=/1952x1098/cloudfront-eu-central-1.images.arcpublishing.com/diarioas/R4WQY77F7BOZZMK6ZLGWVXGG7A.jpg'),
                  fit: BoxFit.cover,
                ),
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
                // Boton Ver Cuenta
                ElevatedButton(
                  onPressed: () {
                    _verCuenta(context, _buttonLabels[index],
                        _buttonLabelsDIC[_buttonLabels[index]]![2]);
                    print(_buttonLabels[index]);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(375, 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    '${_buttonLabels[index]} ',
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
          TextEditingController nombreCuenta = TextEditingController();
          String sNombreCuenta = '';
          TextEditingController nombreUser = TextEditingController();
          String sNombreUser = '';
          TextEditingController pass = TextEditingController();
          String sPass = '';

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
                      hintText: 'Usuario/Mail',
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
                      sNombreCuenta = nombreCuenta.text;
                      sNombreUser = nombreUser.text;
                      sPass = pass.text;
                      // paraMonkeAgregarCuenta("Juan", sNombreCuenta, sNombreUser, sPass);
                      if (sNombreCuenta != '' &&
                          sNombreUser != '' &&
                          sPass != '') {
                        _addButton(sNombreCuenta, '', sNombreUser, sPass);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Añadir cuenta',
        child: const Icon(Icons.add),
      ),
    );
  }
}

void paraMonkeAgregarCuenta(String usuarioMaestro, String nombreServicio,
    String nombreUser, String pass) {}

void revisarMonkeBASEdeDATOS(BuildContext context, String nombreCuenta) {}

void CambioContraAutomatico(BuildContext context, String nombreCuenta) {}

void mostrarContra(BuildContext context, String contra) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Su contraseña es:"),
          content: Text(contra),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(330, 40),
              ),
              child: const Text("Copiar contraseña"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                minimumSize: const Size(330, 40),
              ),
              child: const Text("Cerrar"),
            ),
          ],
        );
      });
}

void _verCuenta(BuildContext context, String nombreCuenta, String pass) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(nombreCuenta),
        content: const Text("Seleccione una opción sobre su cuenta:"),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              mostrarContra(context, pass);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey,
              minimumSize: const Size(330, 40),
            ),
            child: const Text('Mostrar contraseña'),
          ),
          ElevatedButton(
            onPressed: () {
              revisarMonkeBASEdeDATOS(context, nombreCuenta);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(330, 40),
            ),
            child: const Text('Revisar vulnerabilidad'),
          ),
          ElevatedButton(
            onPressed: () {
              CambioContraAutomatico(context, nombreCuenta);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(330, 40),
            ),
            child: const Text('Cambiar contraseña'),
          ),
        ],
      );
    },
  );
}
