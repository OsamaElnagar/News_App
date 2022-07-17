import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/Bloc/states.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../shared/Bloc/cubit.dart';
import '../shared/components/components.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var data = cubit.business;

        return ScreenTypeLayout(
          mobile: articleBuilder(data, context),
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: articleBuilder(data, context)),
              if (data.isNotEmpty)
                Expanded(
                  child: Container(
                    color: Colors.deepOrange,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '${data[cubit.selectedItem]['description']}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          breakpoints: const ScreenBreakpoints(
            desktop: 600.0,
            watch: 600.0,
            tablet: 600.0,
          ),
        );
      },
    );
  }
}
