import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/sports.dart';
import 'package:news/shared/Bloc/states.dart';

import '../../modules/business.dart';
import '../../modules/science.dart';
import '../components/components.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
     Business(),
     const Sports(),
    const Science(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavigationStates());
  }

  List<dynamic> business = [];
  List<bool> businessSelectedItem = [];
  late int selectedItem = 0;
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(
      'v2/top-headlines',
      {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'a13725eb0d4946c58ebdbf6d44d647f8',
      },
    ).then((value) {
      business = value.data['articles'];
      for (var element in business) {
        businessSelectedItem.add(false);
      }
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  void selectedCategoryItem(index) {
    selectedItem = index;
    emit(NewsCategorySelectedItemState());
  }

  void getSports() {
    emit(NewsSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        'v2/top-headlines',
        {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'a13725eb0d4946c58ebdbf6d44d647f8',
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((onError) {
        debugPrint(onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        'v2/top-headlines',
        {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'a13725eb0d4946c58ebdbf6d44d647f8',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        debugPrint(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    search = [];
    DioHelper.getData(
      'v2/everything',
      {
        'q': value,
        'apiKey': 'a13725eb0d4946c58ebdbf6d44d647f8',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((onError) {
      debugPrint(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean('isDark', isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }
  }
}
