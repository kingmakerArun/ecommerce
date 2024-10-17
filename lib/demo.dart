import 'package:flutter/material.dart';
import 'account.dart';
class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.white54],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  const Center(child: Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),)),
                  const SizedBox(height: 10),
                  const Center(child: Text("To", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),)),
                  const SizedBox(height: 10),
                  const Center(child: Text("Shopping Cart...", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),)),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Account()),
                        );
                      },
                      child: const Text("Startup", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
