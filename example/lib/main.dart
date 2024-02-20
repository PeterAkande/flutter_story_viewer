import 'package:flutter/material.dart';
import 'package:flutter_story_viewer/flutter_story_viewer.dart';

void main() {
  FlutterStoryViewer.ensureInitialized();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 400,
              child: FlutterStoryViewer(
                items: [
                  VideoItem(
                    url:
                        'https://townbox.s3.amazonaws.com/static/videos/FastApi_Websocket_Demo_2-19B0B1D7-460E-439A-B3FC-F78041DAB6A8.mp4',
                  ),
                  VideoItem(
                    url:
                        'https://townbox.s3.amazonaws.com/static/videos/FastApi_Websocket_Demo_2-19B0B1D7-460E-439A-B3FC-F78041DAB6A8.mp4',
                  ),
                  VideoItem(
                    url:
                        'https://townbox.s3.amazonaws.com/static/videos/FastApi_Websocket_Demo_2-19B0B1D7-460E-439A-B3FC-F78041DAB6A8.mp4',
                  ),
                  VideoItem(
                    url:
                        'https://townbox.s3.amazonaws.com/static/videos/FastApi_Websocket_Demo_2-19B0B1D7-460E-439A-B3FC-F78041DAB6A8.mp4',
                  ),
                  VideoItem(
                    url:
                        'https://townbox.s3.amazonaws.com/static/videos/FastApi_Websocket_Demo_2-19B0B1D7-460E-439A-B3FC-F78041DAB6A8.mp4',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
