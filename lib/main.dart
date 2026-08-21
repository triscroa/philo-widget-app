import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'philosopher.dart';

void main() {
  runApp(const PhilosophyApp());
}

class PhilosophyApp extends StatelessWidget {
  const PhilosophyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Philosophy Widget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuoteSelectorScreen(),
    );
  }
}

class QuoteSelectorScreen extends StatelessWidget {
  const QuoteSelectorScreen({super.key});

  Future<void> _sendQuoteToWidget(PhilosopherQuote item) async {
    await HomeWidget.saveWidgetData<String>('quote_text', item.quote);
    await HomeWidget.saveWidgetData<String>('quote_author', item.author);
    await HomeWidget.saveWidgetData<String>('quote_school', item.school);
    
    await HomeWidget.updateWidget(
      name: 'PhilosophyWidgetProvider',
      iOSName: 'PhilosophyWidget',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Philosopher Quotes'),
      ),
      body: ListView.builder(
        itemCount: sampleQuotes.length,
        itemBuilder: (context, index) {
          final item = sampleQuotes[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              title: Text(
                '"${item.quote}"',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('— ${item.author} (${item.school})'),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _sendQuoteToWidget(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Updated widget with ${item.author}!')),
                  );
                },
                child: const Text('Set Widget'),
              ),
            ),
          );
        },
      ),
    );
  }
}