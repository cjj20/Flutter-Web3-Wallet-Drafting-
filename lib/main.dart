import 'package:crypwallet/metamask_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
     create: (context) => MetaMaskProvider()..init(),
     builder: (context, child) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
      return Scaffold(
      body:Stack(
       children: [
        Row(
         children: [
          const SizedBox(
           width:15,
          ),
          Image.asset(
            'assets/images/paintball.png',
            width: 200,
            height: 150,
          )
         ],
        ), 
        child:
        Center(
         child: Consumer<MetaMaskProvider>(
          builder: (contect, provider, child) {
           late final String text;
           text = provider.account;
           if (provider.isConnected && provider.isInOperatingChain){
            return Card(
             shape: RoundedRectangleBorder(
              side: const BorderSide(
               color: Colors.white,
               width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
             ),
             elevation: 15,
             shadowColor: Colors.black,
             color: const Color.fromARGB(255, 10, 17, 32),
             child: Container(
               padding: const EdgeInsets.only(left: 15, bottom: 15),
               height: 270, 
               width: 400,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   const Text(
                    "Account",
                    style: TextStyle(
                     color: Colors.white60,
                     fontSize: 24,
                    ),
                   ),
                   Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 150,
                        width: 350,
                        decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(240,
                         border: Border.all(
                           color: Colors.white60,
                           width: 2,
                         ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment:                          
                                MainAxisAlignment.spaceAround,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Connected to MetaMask",
                                style: TextStyle(
                                    color: Colors.white60),
                              ),
                              Text(
                                '${text.substring(0, 7)}...${text.substring(text.length - 4, text.length)}',
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                     _copytext(text);
                                    },
                                    icon: const Icon(
                                        Icons.content_copy_rounded),
                                    color: Colors.white60,
                                  ),
                                  const Text(
                                    "Copy Address",
                                    style: TextStyle(
                                        color: Colors.white600,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                   ),
                 ],
               ),
             ),
            ),
           } else if (provider.isEnabled) {
           return ElevatedButton(
                        onPressed: () =>
                            context.read<MetaMaskProvider>().connect(),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder()
                            primary: Colors.white24,
                            padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Image.asset(
                                "assets/images/MetaMask_Fox.png",
                                height: 30,
                                width: 40,
                              ),
                            ),
                            const Text(
                              "Connect Wallet",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      'Please use a Web3 supported browser.';
                    }
                     return Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                     
                    );
          },
         ),
        ),
       ],
      ),
     );
    },
   );
  }

 
void _showSnackbar() {
  ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(content: Text("Text Copied")));
   }

void _copytext(String copytext) {
  FlutterClipboard.copy(copytext).then((value) => _showSnackbar());



    
 

                      
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
         //      child: Column(
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
         // mainAxisAlignment: MainAxisAlignment.center,
         // children: <Widget>[
           // const Text(
             // 'You have pushed the button this many times:',
           // ),
           // Text(
             // '$_counter',
             // style: Theme.of(context).textTheme.headlineMedium,
           // ),
         // ],
       // ),
     // ),
     // floatingActionButton: FloatingActionButton(
       // onPressed: _incrementCounter,
       // tooltip: 'Increment',
       // child: const Icon(Icons.add),
     // ), // This trailing comma makes auto-formatting nicer for build methods.
  // );
  }
}
