import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:government_services/connection_provider.dart';
import 'package:government_services/gov_services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        debugShowCheckedModeBanner: false,
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
      bool isConnection = event != ConnectivityResult.none;
      Provider.of<ConnectionProvider>(context, listen: false)
          .connectionChange(isConnection);
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
                    child: Center(
                      child: Text(
                        "umang",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "india.gov.in",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CovServices(
                            url: "https://www.rmc.gov.in/",
                          );
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        "rmc",
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CovServices(
                            url:
                                "https://dot.gov.in/national-government-services-portal",
                          );
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "national-government",
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CovServices(
                      url: "https://www.google.com/",
                    ),
                  ),
                );
              },
              child: Text("Google"))
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
          if (value.isConnection) {
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
