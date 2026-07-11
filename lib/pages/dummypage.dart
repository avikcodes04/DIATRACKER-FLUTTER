import "package:flutter/material.dart";

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dummy Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "This is a dummy page.",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Go Back"),
          ),
        ],
      ),
    );
  }
}