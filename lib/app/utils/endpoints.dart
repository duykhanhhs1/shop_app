abstract class Endpoints {
  static const String API_URL = 'https://your-ecommerce.herokuapp.com';
  static const String DOWNLOAD_PHOTO_URL = 'https://dev.goalmaker.com.au:1100';
  static const String VERIFY_EMAIL = '$API_URL/users/same-users';
  static const String LOGIN = '$API_URL/users/login';
  static const String REGISTER = '$API_URL/users/signup';
  static const String PROFILE = '$API_URL/profile';
  static const String REFRESH_TOKEN = '$API_URL/users/refresh-token';
  static const String PRODUCTS = '$API_URL/products';
  static const String SEARCH_PRODUCT = '$API_URL/search';
  static const String CATEGORIES = '$API_URL/categories';
  static const String REVIEWS = '$API_URL/reviews';
  static const String CARTS = '$API_URL/carts';
  static const String ORDERS = '$API_URL/orders';
  static const String UPLOAD_PHOTO = '$API_URL/questionnaires/upload-photo';
}
