

import 'package:bingoadmin/models/jogador.dart';
import 'package:bingoadmin/models/Jogadores.dart';
import 'package:bingoadmin/models/sorteios.dart';
import 'package:bingoadmin/models/vendedor.dart';
import 'package:bingoadmin/screens/cartela_screen.dart';

import 'package:bingoadmin/screens/diversos_screen.dart';
import 'package:bingoadmin/screens/home_admin_screen.dart';
import 'package:bingoadmin/screens/jogador/add_jogador_screen.dart';
import 'package:bingoadmin/screens/jogador/jogador_screen.dart';
import 'package:bingoadmin/screens/sorteio/sorteio_manual_screen.dart';
import 'package:bingoadmin/screens/sorteio/sorteio_screen.dart';
import 'package:bingoadmin/screens/teste/teste_screen.dart';
import 'package:bingoadmin/screens/vendedor/add_vendedor_screen.dart';
import 'package:bingoadmin/screens/vendedor/vendedor_screen.dart';
import 'package:bingoadmin/tema/my_theme.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DateTime now = DateTime.now();
    print("Agora é: $now");

  //CRASHLYTICS
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setUserIdentifier("26721993880");

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  //CRASHLYTICS

  //Provider - Inicializa o Provider
  // Provider - Inicializa o Provider
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Jogadores(jogadores: []),),
          ChangeNotifierProvider(create: (context) => Sorteios(sorteios: []))  
            ],
        child:const MyApp()));

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme,
      initialRoute: "sorteios",
      routes: {
        "teste": (context) => TesteScreen(),
        "diversos": (context) => DiversosScreen(),
        "home": (context) => HomeAdminScreen(),
        "sorteios": (context) => SorteioScreen(),
        "cartelas": (context) => CartelaScreen(),
        "vendedores": (context) => VendedorScreen(),
        "jogadores": (context) => JogadorScreen(),
     
        "sorteio-manual": (context) => SorteioManualScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "teste2") {
          //final Credito credito = settings.arguments as Credito;
          return MaterialPageRoute(builder: (context) {
            return TesteScreen();
          });
        }

        if (settings.name == "vendedores-add") {
          //final Credito credito = settings.arguments as Credito;
          return MaterialPageRoute(builder: (context) {
            return AddVendedorScreen(vendedor: Vendedor.empty(),isEditing: false,);
          });
        }

          if (settings.name == "jogadores-add") {
          //final Credito credito = settings.arguments as Credito;
          return MaterialPageRoute(builder: (context) {
            return AddJogadorScreen(jogador: Jogador.empty(),isEditing: false,);
          });
        }      
        assert(false, 'Precisar ser Implementado ${settings.name}');
        return null;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    FirebaseCrashlytics.instance.crash();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Gera Crash!!! nervoso'),
              onTap: () {
                // print('Vai arrebentar...');
                FirebaseCrashlytics.instance.crash();
              },
            ),
            ListTile(
              title: const Text('Erro Assincrono'),
              onTap: () {
                throw Error();
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('exceções não fatais '),
              onTap: () {
                print("clicou no botao de nao fatais..");
//                 await FirebaseCrashlytics.instance.recordError(
//   error,
//   stackTrace,
//   reason: 'a non-fatal error'
// );
                try {
                  throw ErrorDescription("message alguma coisa!!!!");
                } on Exception catch (meuErro) {
                  FirebaseCrashlytics.instance.log("Cavalo manco do para...");
                  print("Deu erro aqui $meuErro");
                  FirebaseCrashlytics.instance
                      .recordError(meuErro, StackTrace.current);
                  // TODO
                }

                FirebaseCrashlytics.instance.log("Cavalo manco do para...");

// Set a key to a string.
                FirebaseCrashlytics.instance.setCustomKey('str_key', 'hello');

// Set a key to a boolean.
                FirebaseCrashlytics.instance.setCustomKey("bool_key", true);

// Set a key to an int.
                FirebaseCrashlytics.instance.setCustomKey("int_key", 1);

// // Set a key to a long.
// FirebaseCrashlytics.instance.setCustomKey("int_key", 1L);

// // Set a key to a float.
// FirebaseCrashlytics.instance.setCustomKey("float_key", 1.0f);

// Set a key to a double.
                FirebaseCrashlytics.instance.setCustomKey("double_key", 1.0);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
