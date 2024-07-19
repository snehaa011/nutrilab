import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_event.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_state.dart';
import 'package:nutrilab/bloc/menubloc/menu_bloc.dart';
import 'package:nutrilab/bloc/menubloc/menu_event.dart';
import 'package:nutrilab/bloc/menubloc/menu_state.dart';
import 'package:nutrilab/menuitem.dart';
import 'package:nutrilab/models/menuitemmodel.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double mainAxisSpacing = screenWidth * 0.02; 
    final double crossAxisSpacing = screenWidth * 0.02; 
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
            padding: const EdgeInsets.only(top: 5, left: 25),
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
            child: Builder(
      builder: (context) {
        final gstate = context.watch<GetItemsBloc>().state;
        final mstate = context.watch<MenuBloc>().state;
        if (mstate is MenuLoaded){
          final String searchTerm =
                      _searchController.text.toLowerCase();
          List<MenuItemModel> filteredItems =
          mstate.menuItems.where((item) => (item.name.contains(searchTerm) ||
                      item.ingr.contains(searchTerm) ||
                      item.type.contains(searchTerm) ||
                      item.cal.toString().contains(searchTerm)) && 
                      (item.type == _selectedCategory || 
                      _selectedCategory=="All")).toList();
          if (filteredItems.isEmpty){
            return Center(
              child: Text(
                'No items found.',
                style: TextStyle(
                  fontFamily: 'Lalezar',
                  color: Color.fromARGB(255, 83, 83, 83),
                  fontSize: 25,
                ),
              ),
            );
          }
          else{  
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                      // 0.75, // Adjusts the height and width ratio
                      mainAxisSpacing: mainAxisSpacing,
                      crossAxisSpacing: crossAxisSpacing,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final doc = filteredItems[index];
                    
                return MenuItemWidget(
                  fm: doc,
                  name: doc.name,
                  des: doc.des,
                  img: doc.img,
                  ingr: doc.ingr,
                  type: doc.type,
                  cal: doc.cal,
                  price: doc.price,
                  itemId: doc.itemId,
                  isLiked: doc.isLiked,
                  isInCart: doc.isInCart,
                  qt: doc.qt,
                );
              },
                        ),
            );
          }
        }
        else if (gstate is GetItemsInitial){
          context.read<GetItemsBloc>().add(LoadItems(FirebaseAuth.instance.currentUser?.email ?? ""));
        }
        else if (gstate is GetItemsLoading){
          return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 24, 79, 87),
              ),
            );
        }
        else if (gstate is GetItemsLoaded){
          context.read<MenuBloc>().add(LoadMenuItems(gstate.likedItems, gstate.cartItems));
        }
        else if (gstate is GetItemsError || mstate is MenuError){
          return Center(child: Text("Error"));
        }
        return Container();
      }
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
                    106) 
                : Colors.white, 
            foregroundColor: _selectedCategory == category
                ? Colors.white 
                : Color.fromARGB(255, 24, 79,
                    87), 
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
