import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CacheExample(),
    );
  }
}

class CacheExample extends StatefulWidget {
  const CacheExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CacheExampleState createState() => _CacheExampleState();
}

class _CacheExampleState extends State<CacheExample> {
  String cachedData = '';

  @override
  void initState() {
    super.initState();
    _loadCachedData();
  }

  _loadCachedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cachedData = prefs.getString('cached_data') ?? '';
    });
  }

  _saveDataToCache(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cached_data', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cache Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Cached Data: $cachedData'),
            ElevatedButton(
                onPressed: () {
                  _saveDataToCache('Cached Data Example');
                  _loadCachedData();
                },
                child: const Text('Save to Cache'))
          ],
        ),
      ),
    );
  }
}
