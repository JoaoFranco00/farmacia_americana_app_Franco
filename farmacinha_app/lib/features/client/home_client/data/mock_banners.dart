import 'package:farmacia_app/features/client/home_client/data/banner_model.dart';

class MockBanners {
  static List<BannerModel> getBanners() {
    return [
      BannerModel(
        id: '1',
        imageUrl: 'https://img.cdndsgni.com/preview/13019028.jpg',
      ),
      BannerModel(
        id: '2',
        imageUrl: 'https://topsortassets.com/asset_01kn5hbnezf16vayzpjzm23hfa.png',
      ),
    ];
  }
}