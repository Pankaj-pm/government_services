import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:government_services/connection_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConnectionProvider(),
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  @override
  void initState() {
    super.initState();
   Connectivity().onConnectivityChanged.listen((event) {
     bool isConnection= event!=ConnectivityResult.none;
     Provider.of<ConnectionProvider>(context,listen: false).connectionChange(isConnection);
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.red,
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.red,
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      // bottomNavigationBar: StreamBuilder<ConnectivityResult>(
      //   stream: Connectivity().onConnectivityChanged,
      //   builder: (context, snapshot) {
      //     bool isData=snapshot.hasData;
      //     print("isData $isData");
      //     ConnectivityResult? result=snapshot.data;
      //     bool isConnected=result!=ConnectivityResult.none;
      //     return Container(
      //       color: isConnected ? Colors.green :Colors.red,
      //       height: 30,
      //       alignment: Alignment.center,
      //       child: Text( isConnected ?"Connected": "not Connected",style: TextStyle(color: Colors.white),),
      //     );
      //   }
      // ),
      bottomNavigationBar: Consumer<ConnectionProvider>(
        builder: (context, value, child) {
          if(value.isConnection){
            return SizedBox();
          }
          return Container(
          color: value.isConnection ? Colors.green : Colors.red,
          height: 30,
          alignment: Alignment.center,
          child: Text(
            value.isConnection ? "Connected" : "No connection ",
            style: TextStyle(color: Colors.white),
          ),
        );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ConnectivityResult con = await Connectivity().checkConnectivity();

          if (con == ConnectivityResult.wifi ||
              con == ConnectivityResult.mobile ||
              con == ConnectivityResult.ethernet) {
            print("Connection");
          } else {
            print(" not Connection");
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
