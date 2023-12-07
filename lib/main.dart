import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      setIconBadge(_counter);
    });
  }

  /// 1以上の数値を渡すことでホーム画面のアイコンにバッジを表示する
  void setIconBadge(number) async {
    // バッジ表示機能に対応している場合のみ、バッジの数字を更新する
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      FlutterAppBadger.updateBadgeCount(number ?? 0);
    } else {
      print("バッジ表示機能に対応していない");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  FlutterAppBadger.removeBadge();
                },
                icon: const Icon(Icons.remove_circle),
                label: const Text('バッジを非表示')),
          ],
        ),
      ),
    );
  }
}
