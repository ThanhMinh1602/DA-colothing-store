class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const forgotPass = '/forgot-pass';
  static const main = '/main'; // chứa bottom nav: home, cart, profile
  static const checkout = '/checkout';
  // Bạn có thể thêm route con cho từng tab nếu muốn, VD:
  static const home = '/main/home';
  static const productDetail = '/main/home/product-detail';
  static const cart = '/main/cart';
  static const profile = '/main/profile';
  static const profileEdit = '/main/profile/edit';
  static const favourite = '/main/favourite';
  static const order = '/main/profile/order';
  static const chatBot = '/main/profile/chat-bot';
}

class WebRouter {
  // Auth
  static const login = '/login';
  // Dashboard
  static const dashboard = '/dashboard';

  // Product Management
  static const productManager = '/products';
  static const productCreate = '/products/create';
  static const productEdit = '/products/edit/:id'; // :id là tham số sản phẩm

  // Category Management
  static const categoryManager = '/categories';
  static const categoryCreate = '/categories/create';
  static const categoryEdit = '/categories/edit/:id';

  // Order Management
  static const orderManager = '/orders';
  static const orderDetail = '/orders/:id';

  // Customer Management (tuỳ bạn có làm không)
  static const customerManager = '/customers';
  static const customerDetail = '/customers/:id';

  static const chatBot = '/chat-bot';
}
