import 'package:flutter/material.dart';

void main() {
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
      home: const MyHomePage(title: 'Flutter Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  Color colors = Colors.blue;
  double values = 100;

  @override
  // void initState() {
  //   animationController = AnimationController(
  //     value: values,
  //     vsync: this,
  //     lowerBound: values,
  //     upperBound: 300,
  //     duration: Duration(milliseconds: 300),
  //   );
  //   animationController.addListener(() {
  //     setState(() {
  //       values = animationController.value;
  //     });
  //   });
  //   super.initState();
  // }

  run() {
    setState(() {
      if (colors == Colors.blue && values == 300) {
        colors = Colors.green;
      } else {
        colors = Colors.blue;
      }
    });
    if (animationController.isCompleted) return animationController.reverse();
    if (animationController.isDismissed) return animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: values,
          width: values,
          color: colors,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: run,
        child: const Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
