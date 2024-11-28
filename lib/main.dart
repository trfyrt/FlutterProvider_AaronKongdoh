import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
      appBar: AppBar(title: Text('Advanced Counter App')),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView.builder(
              itemCount: globalState.counters.length,
              onReorder: globalState.reorderCounters,
              itemBuilder: (context, index) {
                final counter = globalState.counters[index];
                return Card(
                  key: ValueKey(counter),
                  color: counter.color.withOpacity(0.2),
                  child: ListTile(
                    title: Text(
                      '${counter.label}: ${counter.value}',
                      style: TextStyle(color: counter.color),
                    ),
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
                          icon: Icon(Icons.color_lens),
                          onPressed: () {
                            _showColorPicker(context, globalState, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showLabelDialog(context, globalState, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => globalState.removeCounter(index),
                        ),
                      ],
                    ),
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

  void _showColorPicker(
      BuildContext context, GlobalState globalState, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Counter Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: globalState.counters[index].color,
              onColorChanged: (color) {
                globalState.updateCounterColor(index, color);
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void _showLabelDialog(
      BuildContext context, GlobalState globalState, int index) {
    final controller =
        TextEditingController(text: globalState.counters[index].label);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Counter Label'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Label'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                globalState.updateCounterLabel(index, controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
