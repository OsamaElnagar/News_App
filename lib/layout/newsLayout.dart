import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search.dart';
import 'package:news/shared/components/components.dart';
import '../shared/Bloc/cubit.dart';
import '../shared/Bloc/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   onPressed: ()
          //   {
          //     debugPrint('Osama clicked');
          //   },
          // child: const Icon(Icons.add),
          // ),
          appBar: AppBar(
            title: const Text('News'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, Search());
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeAppMode();
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
