import 'package:flutter/material.dart';

class YSayfasi extends StatefulWidget {
  const YSayfasi({super.key});

  @override
  State<YSayfasi> createState() => _YSayfasiState();
}

class _YSayfasiState extends State<YSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Y Sayfası"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                 Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("AnaSayfaya Git"))
          ],
        ),
      ),
    );
  }
}