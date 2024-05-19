import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrilab/menuitem.dart';

class GoToMenuPage extends StatefulWidget {
  const GoToMenuPage({super.key});

  @override
  State<GoToMenuPage> createState() => _GoToMenuPageState();
}

class _GoToMenuPageState extends State<GoToMenuPage> {
  // ignore: unused_field
  String _searchTerm = '';
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'NUTRILAB',
              style: TextStyle(
                  color: Color.fromARGB(255, 24, 79, 87),
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Genos'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _searchController,
              cursorColor: Color.fromARGB(255, 24, 79, 87),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Color.fromARGB(255, 24, 79, 87),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Color.fromARGB(255, 49, 49, 49),
                  ), // Green border when enabled
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Color.fromARGB(255, 71, 71, 71),
                  ), // Green border when focused
                ),
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    if (mounted) {
                      setState(() {
                        _searchTerm = '';
                      });
                    }
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    _searchTerm = value.trim();
                  });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Categories',
              style: TextStyle(
                  fontFamily: 'Lalezar',
                  color: Color.fromARGB(255, 24, 79, 87),
                  fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 55,
                child: Row(
                  children: [
                    _buildCategoryButton('All'),
                    _buildCategoryButton('Breakfast'),
                    _buildCategoryButton('Lunch'),
                    _buildCategoryButton('Dinner'),
                    _buildCategoryButton('Drinks'),
                    _buildCategoryButton('Snack'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('menuitems')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('ERROR'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 24, 79, 87),
                    ),
                  );
                }

                final List<DocumentSnapshot> filteredMenuItems =
                    snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final String searchTerm =
                      _searchController.text.toLowerCase();
                  final String name = data['Name']?.toLowerCase() ?? '';
                  final String ingr = data['Ingr']?.toLowerCase() ?? '';
                  final String type = data['Type']?.toLowerCase() ?? '';
                  final int calories = data['Calories'] ?? 0;

                  final matchesSearchTerm = name.contains(searchTerm) ||
                      ingr.contains(searchTerm) ||
                      type.contains(searchTerm) ||
                      calories.toString().contains(searchTerm);

                  final matchesCategory = _selectedCategory == 'All' ||
                      type == _selectedCategory.toLowerCase();

                  return matchesSearchTerm && matchesCategory;
                }).toList();

                if (filteredMenuItems.isEmpty) {
                  return Center(
                    child: Text(
                      'No items found.',
                      style: TextStyle(
                          fontFamily: 'Lalezar',
                          color: Color.fromARGB(255, 83, 83, 83),
                          fontSize: 25),
                    ),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        0.75, // Adjusts the height and width ratio
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: filteredMenuItems.length,
                  itemBuilder: (context, index) {
                    final doc = filteredMenuItems[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return MenuItemWidget(
                      name: data['Name'],
                      des: data['Description'],
                      img: data['Image'],
                      ingr: data['Ingr'],
                      type: data['Type'],
                      cal: data['Calories'],
                      price: data['Price'],
                      itemId: doc.id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (mounted) {
              setState(() {
                _selectedCategory = category;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedCategory == category
                ? Color.fromARGB(255, 125, 172,
                    106) // Green background for selected category
                : Colors.white, // Default background for unselected categories
            foregroundColor: _selectedCategory == category
                ? Colors.white // White text for selected category
                : Color.fromARGB(255, 24, 79,
                    87), // Default text color for unselected categories
            // side: BorderSide(
            //     color: Color.fromARGB(255, 24, 79, 87)), // Border color
          ),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
