import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/Bloc/cubit.dart';
import 'package:news/shared/Bloc/states.dart';
import 'package:news/shared/components/components.dart';

// ignore: must_be_immutable
class Search extends StatelessWidget {
   Search({Key? key}) : super(key: key);
  var searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, NewsStates state) {},
      builder: (BuildContext context, NewsStates state) {
        var data = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' search must not be empty';
                    }
                    return null;
                  },
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Search'),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Expanded(child: articleBuilder(data, context))
            ],
          ),
        );
      },
    );
  }
}
