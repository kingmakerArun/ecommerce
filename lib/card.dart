import 'package:ecommerce/shipping.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    const shippingCost = 100;
    double subtotal = 0;
    cartProvider.cartItems.forEach((item, quantity) {
      final price = double.parse(item.price.replaceAll('₹ ', '').replaceAll(',', ''));
      subtotal += price * quantity;
    });
    final total = subtotal + shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          onPressed: () {Navigator.pop(context); },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(child: Text('No items in the cart'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems.keys.elementAt(index);
                final quantity = cartProvider.cartItems[item]!;
                final price = double.parse(item.price.replaceAll('₹ ', '').replaceAll(',', ''));
                final total = price * quantity;

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
                              child: Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.price,style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (quantity > 1) {
                                        cartProvider.addToCart(item, -1); // Decrease quantity
                                      } else {
                                        cartProvider.removeFromCart(item); // Remove item if quantity is 1
                                      }
                                    },
                                    highlightColor: Colors.grey,
                                  ),
                                  Text('$quantity',style: const TextStyle(fontSize: 18, color: Colors.black),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      cartProvider.addToCart(item, 1); // Increase quantity
                                    },
                                    highlightColor: Colors.grey,
                                  ),
                                  const SizedBox(width: 35),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      cartProvider.removeFromCart(item);
                                    },
                                    color: Colors.red,
                                  ),
                                ],
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Subtotal:', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 210),
                    Text('₹ ${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  children: [
                    const Text('Shipping Cost:', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 190),
                    Text('₹ ${shippingCost.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 210),
                    Text('₹ ${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Shipping(cartItems: cartProvider.cartItems), // Pass the cart items
                        ),
                      );
                    },
                    child: const Text('Checkout →', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}