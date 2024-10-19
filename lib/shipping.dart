import 'package:flutter/material.dart';
import 'cart_provider.dart';
import 'home.dart';

class Shipping extends StatelessWidget {
  final Map<Item, int> cartItems; // Pass the cart items

  const Shipping({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Details'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('No items in the cart'))
          : Column(
            children: [
              Expanded(
                child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                final item = cartItems.keys.elementAt(index);
                final quantity = cartItems[item]!;
                final price = double.parse(item.price.replaceAll('₹ ', '').replaceAll(',', ''));
                final total = price * quantity+100;
                return Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150, // Adjust height as needed
                          width: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(item.imageUrl), // Correct usage
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(item.title,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Total: ₹ ${total.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
                        },
                      ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(
                        builder: (context) => const Home(), // Pass the cart items
                      ),
                    );
                  },
                  child: const Text('Back to Purchase', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              ),
            ],
          ),
    );
  }
}
