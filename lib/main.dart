import 'dart:math';
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

class QuoteSelectorScreen extends StatefulWidget {
  const QuoteSelectorScreen({super.key});

  @override
  State<QuoteSelectorScreen> createState() => _QuoteSelectorScreenState();
}

class _QuoteSelectorScreenState extends State<QuoteSelectorScreen> {
  PhilosopherQuote _currentQuote = PhilosopherQuote.samples[0];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Ensure the widget has initial data populated when the app first launches
    _updateWidgetData();
  }

  Future<void> _updateWidgetData() async {
    // Save data to shared storage for the home screen widget
    await HomeWidget.saveWidgetData<String>('quote_text', _currentQuote.quote);
    await HomeWidget.saveWidgetData<String>('quote_author', _currentQuote.author);
    await HomeWidget.saveWidgetData<String>('quote_school', _currentQuote.school);
    
    // Tell the home widget to update itself using the correct Android receiver name
    await HomeWidget.updateWidget(
      name: 'PhilosophyWidgetReceiver',
      androidName: 'PhilosophyWidgetReceiver',
    );
  }

  void _selectRandomQuote() {
    setState(() {
      int index = _random.nextInt(PhilosopherQuote.samples.length);
      _currentQuote = PhilosopherQuote.samples[index];
    });

    // Push the new quote data to the home screen widget
    _updateWidgetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Philosopher Quotes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      '"${_currentQuote.quote}"',
                      style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '- ${_currentQuote.author}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(_currentQuote.school),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _selectRandomQuote,
              icon: const Icon(Icons.refresh),
              label: const Text('New Quote'),
            ),
          ],
        ),
      ),
    );
  }
}