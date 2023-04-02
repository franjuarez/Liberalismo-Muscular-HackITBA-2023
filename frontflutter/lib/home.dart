import 'dart:convert';
import 'package:example/providers/change_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

ValueNotifier<Map<String, dynamic>> filtradasAuxTRUE = ValueNotifier({
  'Dropbox': ['Valen', 'asdsad'],
  'Facebook': ['Valen', 'TengoMiedo'],
  'Instagram': ['Valen', 'nosequeponer']
});

List<Map<String, List<String>>> leerCsv(String nombreArchivo) {
  final file = File(nombreArchivo);
  final List<List<dynamic>> filas = file
      .openRead()
      .transform(utf8.decoder)
      .transform(const CsvToListConverter(fieldDelimiter: ';'))
      .toList() as List<List>;

  final List<Map<String, List<String>>> resultado = [];
  for (final fila in filas) {
    final dominio = fila[0].toString();
    final usuario = fila[1].toString();
    final contrasena = fila[2].toString();
    resultado.add({
      dominio: [usuario, contrasena]
    });
  }
  return resultado;
}

Map<String, List> obtenerBotones(List<Map<String, List<String>>> usuarioCsv) {
  final Map<String, List> buttonLabelsDIC = {};
  for (final fila in usuarioCsv) {
    final dominio = fila.keys.first;
    final usuario = fila.values.first[0];
    final contrasena = fila.values.first[1];
    buttonLabelsDIC[dominio] = [usuario, contrasena];
  }
  return buttonLabelsDIC;
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _buttonLabels = ['Twitter', 'Facebook', 'Instagram'];
  final Map<String, List> _buttonLabelsDIC = {
    'Twitter': ['Valen', '12345'],
    'Facebook': ['Valen', 'TengoMiedo'],
    'Instagram': ['Valen', 'nosequeponer']
  };

  void _addButton(String sNombreCuenta, String sNombreUser, String sPass) {
    setState(() {
      _buttonLabels.add(sNombreCuenta);
      _buttonLabelsDIC[sNombreCuenta] = [sNombreUser, sPass];
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
                      'https://www.pantallasamigas.net/wp-content/uploads/2021/05/programas-gestion-contrasenas.png'),
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
                filtradasAuxTRUE.value['Twitter'] = ['Valen', '12345'];

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
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Stack(
              // crear botones con el nombre de la cuenta DESDE CSV
              alignment: Alignment.center,
              children: [
                // Boton Ver Cuenta
                ElevatedButton(
                  onPressed: () {
                    _verCuenta(
                        context,
                        _buttonLabels[index],
                        _buttonLabelsDIC[_buttonLabels[index]]![1],
                        _buttonLabelsDIC,
                        filtradasAuxTRUE);
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
                        _addButton(sNombreCuenta, sNombreUser, sPass);
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

void agregarCuenta(String usuarioMaestro, String nombreServicio,
    String nombreUser, String pass) {}

Future<String> MandarCuentaFiltrada(String nombreCuenta, String usuario) async {
  var url = Uri.parse('http://localhost:8000/login');
  var response =
      await http.post(url, body: {'usuario': usuario, 'dominio': nombreCuenta});
  return response.body;
}

Future<String> cambiarContra(BuildContext context, String nombreCuenta, String usuario, String contra) async {
  print("Cambio de contraseña en: " + nombreCuenta);
  return await MandarCuentaFiltrada(nombreCuenta, usuario);
}

void revisarContra(
    BuildContext context,
    String nombreCuenta,
    Map<String, List<dynamic>> propias,
    ValueNotifier<Map<String, dynamic>> filtrados) {
  propias.forEach((key, value) {
    if (nombreCuenta != '' && key != nombreCuenta) {
      return;
    }
    filtrados.value.forEach((key2, value2) {
      if (value[0] == value2[0] && value[1] == value2[1]) {
        Future<String> passNueva = cambiarContra(context, nombreCuenta, value[0], value[1]);
        print("Cambio de contraseña en: " + key + "contra nueva: " + passNueva.toString());
      } else {
        print("CONTRA SEGURA");
      }
    });
  });
}

void mostrarContra(BuildContext context, String contra) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Su contraseña es:"),
          content: Text(contra),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Texto copiado al portapapeles'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(330, 40),
                ),
                child: const Text("Copiar contraseña"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  minimumSize: const Size(330, 40),
                ),
                child: const Text("Cerrar"),
              ),
            ),
          ],
        );
      });
}

void _verCuenta(
    BuildContext context,
    String nombreCuenta,
    String pass,
    Map<String, List<dynamic>> propias,
    ValueNotifier<Map<String, dynamic>> filtrados) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(nombreCuenta),
        content: const Text("Seleccione una opción sobre su cuenta:"),
        actions: <Widget>[
          Center(
            child: ElevatedButton(
              onPressed: () {
                mostrarContra(context, pass);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                minimumSize: const Size(330, 40),
              ),
              child: const Text('Mostrar contraseña'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                //revisarMonkeBASEdeDATOS(context, nombreCuenta);
                revisarContra(context, nombreCuenta, propias, filtrados);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(330, 40),
              ),
              child: const Text('Revisar vulnerabilidad'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(330, 40),
              ),
              child: const Text('Cambiar contraseña'),
            ),
          ),
        ],
      );
    },
  );
}
