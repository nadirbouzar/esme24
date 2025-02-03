import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipezone/domains/location_manager.dart';
import 'package:swipezone/domains/locations_usecase.dart';
import 'package:swipezone/screens/widgets/location_card.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  void createDatabase() async {

  }
  int likeCount = 0;
  Future<void> _scanNFC() async {
    try {
      await FlutterNfcKit.poll();
      setState(() {
        likeCount++;
      });
    } catch (e) {
      print("Erreur NFC : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: LocationUseCase().getLocation(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Text("No data");
            }

            LocationManager().locations = data;

            return ListView(children: [
              LocationCard(location: data[LocationManager().currentIndex]),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Text("Like: $likeCount",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 20)),
                  ],
                ),
              ),
              Center(
                child: FilledButton(
                    onPressed: () {
                      GoRouter.of(context).go('/selectpage');
                    },
                    child: const Text("Create plan")),
              )
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanNFC,
        tooltip: 'Add plan',
        child: const Icon(Icons.add),
      ),
    );
  }
}
