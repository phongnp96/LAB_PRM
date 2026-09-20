// Lab 3 - Advanced Dart Practice Exercises
// Người làm: Phong

import 'dart:async';
import 'dart:convert';

void main() async {
  print('--- EXERCISE 1: Product Model & Repository ---');
  await exercise1();

  print('\n--- EXERCISE 2: User Repository with JSON ---');
  await exercise2();

  print('\n--- EXERCISE 3: Async + Microtask Debugging ---');
  exercise3();
  // Đợi một chút để EX 3 in xong mới chạy EX 4 (do tính chất bất đồng bộ)
  await Future.delayed(Duration(milliseconds: 100));

  print('\n--- EXERCISE 4: Stream Transformation ---');
  await exercise4();

  print('\n--- EXERCISE 5: Factory Constructors & Cache ---');
  exercise5();
}

// ==========================================
// EXERCISE 1: Product Model & Repository
// ==========================================
class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);
}

class ProductRepository {
  // Tạo một Stream Controller phát sóng (broadcast) để cập nhật real-time
  final StreamController<Product> _controller = StreamController<Product>.broadcast();

  // Trả về luồng dữ liệu (Stream)
  Stream<Product> get liveAdded => _controller.stream;

  // Giả lập lấy danh sách sản phẩm từ database tốn 1 giây
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      Product(1, 'Laptop', 1500.0),
      Product(2, 'Chuột máy tính', 25.0),
    ];
  }

  // Hàm thêm sản phẩm mới và phát tín hiệu lên Stream
  void addProduct(Product product) {
    _controller.add(product);
  }

  // Nhớ đóng luồng khi không dùng nữa để tránh rò rỉ bộ nhớ
  void close() => _controller.close();
}

Future<void> exercise1() async {
  var repo = ProductRepository();

  // Lắng nghe (Listen) các sản phẩm mới được thêm vào (Real-time updates)
  repo.liveAdded.listen((product) {
    print('Stream nhận được sản phẩm mới: ${product.name} - \$${product.price}');
  });

  // Lấy toàn bộ danh sách bằng Future
  print('Đang tải danh sách sản phẩm...');
  var list = await repo.getAll();
  print('Đã lấy được ${list.length} sản phẩm.');

  // Thử thêm sản phẩm để Stream hoạt động
  repo.addProduct(Product(3, 'Bàn phím cơ', 100.0));

  repo.close();
}

// ==========================================
// EXERCISE 2: User Repository with JSON
// ==========================================
class User {
  String name;
  String email;

  User(this.name, this.email);

  // Constructor dùng để chuyển dữ liệu JSON thành đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['email']);
  }
}

Future<void> exercise2() async {
  // Cấu trúc chuỗi JSON giả lập lấy từ API
  String jsonString = '''
  [
    {"name": "Phong", "email": "phong@fpt.edu.vn"},
    {"name": "Nam", "email": "nam@fpt.edu.vn"}
  ]
  ''';

  // Parse (giải mã) chuỗi JSON thành List 
  List<dynamic> parsedList = jsonDecode(jsonString);

  // Biến danh sách JSON thành danh sách đối tượng User thông qua Future
  Future<List<User>> fetchUsers() async {
    return parsedList.map((jsonItem) => User.fromJson(jsonItem)).toList();
  }

  List<User> users = await fetchUsers();
  print('Danh sách User lấy từ API:');
  for (var user in users) {
    print('- ${user.name} (${user.email})');
  }
}

// ==========================================
// EXERCISE 3: Async + Microtask Debugging
// ==========================================
void exercise3() {
  print('1. Lệnh in đồng bộ (Chạy ngay lập tức)');

  // Future sẽ bị xếp vào Event Queue (Hàng đợi sự kiện), chạy cuối cùng
  Future(() => print('4. Future chạy (Thuộc Event Queue)'));

  // Microtask sẽ được ưu tiên chạy trước Future
  scheduleMicrotask(() => print('3. Microtask chạy (Ưu tiên cao hơn Event Queue)'));

  print('2. Lệnh in đồng bộ tiếp theo (Chạy ngay lập tức)');

  // Giải thích: Code đồng bộ chạy trước -> Microtask chạy -> Future chạy cuối.
}

// ==========================================
// EXERCISE 4: Stream Transformation
// ==========================================
Future<void> exercise4() async {
  // Tạo một luồng phát ra các số từ 1 đến 5
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Lọc và bình phương các số từ 1 đến 5 (chỉ lấy số chẵn):');

  await numbers
      .map((n) => n * n) // Biến đổi: Bình phương từng số lên (1, 4, 9, 16, 25)
      .where((n) => n % 2 == 0) // Lọc: Chỉ giữ lại các số chẵn (4, 16)
      .listen((result) { // Lắng nghe và in ra
    print('Kết quả sau khi transform: $result');
  })
      .asFuture(); // Đợi stream chạy xong hết mới đi tiếp
}

// ==========================================
// EXERCISE 5: Factory Constructors & Cache
// ==========================================
class Settings {
  // Biến static lưu trữ thể hiện duy nhất của lớp này (Singleton pattern)
  static final Settings _instance = Settings._internal();

  // Factory constructor: Thay vì tạo mới, nó luôn trả về _instance có sẵn
  factory Settings() {
    return _instance;
  }

  // Constructor nội bộ (private) có dấu _ ở trước
  Settings._internal();
}

void exercise5() {
  // Thử tạo ra 2 biến Settings
  var settingsA = Settings();
  var settingsB = Settings();

  // Kiểm tra xem hai biến này có cùng trỏ vào 1 vùng nhớ không
  bool isSame = identical(settingsA, settingsB);

  print('Settings A và Settings B có phải là một (Singleton) không?');
  print('Kết quả (identical): $isSame');
}