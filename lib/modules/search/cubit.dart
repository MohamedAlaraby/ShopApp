import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search/search_model.dart';
import 'package:shop_app/modules/search/states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/endpoints.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data: {'text':text},
      token: token,
    ).then((value)
    {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }
    ).catchError((error)
    {
      emit(SearchErrorState());
      print('the error is:: $error');
    }
    );
  }
}
