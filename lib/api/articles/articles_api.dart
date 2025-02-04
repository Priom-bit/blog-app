import 'package:blog_app/api/articles/responses/get_everything_response.dart';
import 'package:flutter/cupertino.dart';

import '../../bloc/home/home_bloc.dart';
import '../../constants/constants.dart';
import '../../network/dio_client.dart';

class ArticlesApi {

  static const _everything = 'everything';
  static const _topHeadlines = 'top-headlines';

  late final DioClient dioClient = DioClient.instance;

  ArticlesApi();

  Future<GetEverythingResponse> getEverything() async {
    try {
      await Future.delayed(const Duration(seconds: DioClient.testDelaySec));
      final response = await dioClient.get(
          _everything,
          queryParameters: {'apiKey': Constants.apiKey, 'q': ''}
      );
      return response as GetEverythingResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetEverythingResponse> getTopHeadlines(int pageNum, String? query) async {
    try {
      await Future.delayed(const Duration(seconds: DioClient.testDelaySec));
      final response = await dioClient.get(_topHeadlines, queryParameters: {
        'apiKey': Constants.apiKey,
        'country': 'us',
        'page': pageNum,
        'q': query,
        'pageSize': HomeBloc.pageSize,
      });
      return GetEverythingResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("ArticlesApi: Exception - $e");
      rethrow;
    }
  }
}