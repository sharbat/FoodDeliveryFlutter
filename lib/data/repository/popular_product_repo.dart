import 'package:fooddelivery/data/api/api_client.dart';
import 'package:fooddelivery/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    /////////////////////////////////////////////////////////////
    return await apiClient.getData(AppConstans.POPULAR_PRODUCT_URL);
  }
}
