import 'package:flutter/material.dart';
import 'package:flutter_broadcasts/flutter_broadcasts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //qual evento queremos escutar
  BroadcastReceiver receiver = BroadcastReceiver(names: [
    "com.android.server.scannerservice.broadcast",
  ]);
  List<String> results = [];
  bool waiting = false; //variavel para controlar a escuta do broadcast
  // ele envia varios repetidos

  @override
  void initState() {
    super.initState();
    //iniciar a escuta do broadcast
    receiver.start();

    //ao escutar um evento
    receiver.messages.listen((msg) {
      if (waiting) {
        return;
      }
      waiting = true;
      Future.delayed(const Duration(seconds: 1), () {
        waiting = false;
      });
      setState(() {
        results.add(msg.data!['scannerdata']);
      });
    });
  }

  @override
  void dispose() {
    //encerrar a escuta do broadcast
    receiver.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("AutoID10 Broadcast"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (context, index) =>
                      ListTile(title: Text(results[index])))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              child: const Text("Limpar"),
              onPressed: () {
                setState(() {
                  results.clear();
                });
              },
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
