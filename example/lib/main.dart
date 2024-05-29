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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Story View'),
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
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.8,
              child: const FlutterStoryViewer(
                backgroundColor: Colors.grey,
                items: [
                  VideoItem(
                    url:
                        'https://townbox.s3.amazonaws.com/static/videos/FastApi_Websocket_Demo_2-19B0B1D7-460E-439A-B3FC-F78041DAB6A8.mp4',
                  ),
                  VideoItem(
                    url:
                        'https://user-images.githubusercontent.com/28951144/229373709-603a7a89-2105-4e1b-a5a5-a6c3567c9a59.mp4',
                  ),
                  VideoItem(
                    url:
                        'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4',
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
