
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumla/modouls/search_modouls.dart';
import 'package:jumla/shared/cubit/search_states.dart';
import 'package:jumla/shared/local/shared_pref.dart';
import 'package:jumla/shared/remote/dio_helper.dart';
import 'package:jumla/shared/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(ShopInitialSearch());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel ? model;
  void getSearchData({required text}){
    emit(ShopLoadingSearch());

    DioHelper.postData(
        url:SEARCH ,
        data:{
          'text':text,
        },
        token: CashHelper.getData(key: 'token'),
        ).then((value) {



      model=SearchModel.fromJson(value.data);

      emit(ShopSuccessSearch());
    }

    ).catchError((error){

      emit(ShopErrorSearch());
    });
  }

}