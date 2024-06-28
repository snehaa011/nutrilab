import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_event.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_state.dart';
import 'package:nutrilab/bloc/menubloc/menu_bloc.dart';
import 'package:nutrilab/bloc/menubloc/menu_event.dart';
import 'package:nutrilab/bloc/menubloc/menu_state.dart';
import './menuitem.dart';

class BuildSaved extends StatelessWidget {
  BuildSaved({super.key});
  final user= FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final gstate = context.watch<GetItemsBloc>().state;
        final mstate = context.watch<MenuBloc>().state;
        if (gstate is GetItemsInitial){
          context.read<GetItemsBloc>().add(LoadItems(user?.email ?? ""));
        }
        if (gstate is GetItemsLoading || mstate is MenuLoading){
          return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 24, 79, 87),
              ),
            );
        }
        if (gstate is GetItemsLoaded){
          context.read<MenuBloc>().add(LoadMenuItems(gstate.likedItems, gstate.cartItems));
        }
        if (gstate is GetItemsError && mstate is MenuError){
          return Center(child: Text("Error"));
        }
        if (mstate is MenuLoaded){
          if (mstate.likedItems.isEmpty){
            return Center(
              child: Text(
                'No items saved.',
                style: TextStyle(
                  fontFamily: 'Lalezar',
                  color: Color.fromARGB(255, 83, 83, 83),
                  fontSize: 25,
                ),
              ),
            );
          }
          else{
            return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: mstate.likedItems.length,
            itemBuilder: (context, index) {
              final doc = mstate.likedItems[index];
      
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
          );
          }
        }
        return Container();
      }
    );
  }
}



