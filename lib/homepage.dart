import 'package:ecommerce/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card.dart';
import 'cart_provider.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String? selectedButton;
  final List<Item> items = [
    Item('Black Skirt', '₹ 3999', 'assets/ladies skirt.jpg'),
    Item('Casual Pants', '₹ 2099', 'assets/pant.jpg'),
    Item('Jacket', '₹ 5099', 'assets/jacket.jpg'),
    Item('Shirt', '₹ 5999', 'assets/shirt.jpg'),
    Item('Jacket', '₹ 5099', 'assets/jacket-2.jpg'),
    Item('Casual Pants', '₹ 2399', 'assets/pant-2.jpg'),
    Item('T Shirt', '₹ 5999', 'assets/tshirt.jpg'),
    Item('Pants', '₹ 5999', 'assets/womens pants.jpg'),
  ];
  Map<Item, int> cartItems = {};
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute( builder: (context) => const Profile(), // Ensure this is correct
              ),
            );
          }, icon: Icon(Icons.person_3_rounded,color: Colors.pink)),
          title: const Column(
            children: [
              Text("Welcome Back!", style: TextStyle(color: Colors.grey)),
              Text("Arun", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const CartPage(), // Ensure this is correct
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "What you are looking for....",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius. all(Radius. circular(10.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSelectableButton("All"),
                    const SizedBox(width: 10),
                    _buildSelectableButton("T Shirt"),
                    const SizedBox(width: 10),
                    _buildSelectableButton("Shirt"),
                    const SizedBox(width: 10),
                    _buildSelectableButton("Jacket"),
                    const SizedBox(width: 10),
                    _buildSelectableButton("Pant"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.filter_alt),
                    SizedBox(width: 10,),
                    Text("Filters"),
                  ],
                ),
              ),
              SizedBox(
                height: 600,
                child: ListView.builder(
                  itemCount: (items.length + 1) ~/ 2, // Adjust for pairs
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCard(index * 2),
                        if (index * 2 + 1 < items.length) // Check if second card exists
                          _buildCard(index * 2 + 1),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCard(int index) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150, // Adjust height as needed
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(items[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              items[index].title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(items[index].price,style: const TextStyle(color: Colors.green,fontWeight:FontWeight.bold,fontSize: 18),),
                const SizedBox(width: 60),
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  onPressed: () {
                    _showAddToCartDialog(index);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _showAddToCartDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Cart'),
          content: Text('Do you want to add "${items[index].title}" to your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addToCart(items[index], 1);
                Navigator.of(context).pop();
              },
              child: const Text('Add to Cart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  Widget _buildSelectableButton(String buttonText) {
    bool isSelected = selectedButton == buttonText;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = buttonText; // Set selected button
        });
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white38, // Black background if selected
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            buttonText,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
