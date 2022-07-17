

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/Bloc/states.dart';

import '../shared/Bloc/cubit.dart';
import '../shared/components/components.dart';

class Science extends StatelessWidget {
  const Science({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var data = NewsCubit.get(context).science;
        return articleBuilder(data,context);
      },
    );
  }
}
