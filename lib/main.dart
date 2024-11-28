import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_state/global_state.dart'; // Import package

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterApp(),
    );
  }
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Global Counter App')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: globalState.counters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      'Counter ${index + 1}: ${globalState.counters[index]}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => globalState.decrementCounter(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => globalState.incrementCounter(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => globalState.removeCounter(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: globalState.addCounter,
            child: Text('Add Counter'),
          ),
        ],
      ),
    );
  }
}
