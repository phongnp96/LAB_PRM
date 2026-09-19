// Lab 2 - Dart Essentials Practice Lab
// Người làm: Phong

void main() async {
  print('--- EX 1: Cú pháp cơ bản ---');
  exercise1();

  print('\n--- EX 2: Collection & Toán tử ---');
  exercise2();

  print('\n--- EX 3: Điều kiện, Vòng lặp & Hàm ---');
  exercise3();

  print('\n--- EX 4: Lập trình hướng đối tượng (OOP) ---');
  exercise4();

  print('\n--- EX 5: Bất đồng bộ & Null Safety ---');
  await exercise5(); // Phải có await vì hàm này có thời gian chờ

  print('\nHoàn thành tất cả bài tập!');
}

// -----------------------------------------
// EXERCISE 1: Biến và kiểu dữ liệu cơ bản
// -----------------------------------------
void exercise1() {
  int age = 21;
  double score = 8.5;
  String name = "Phong";
  bool isStudent = true;

  // In ra màn hình bằng String Interpolation ($)
  print('Tên: $name');
  print('Tuổi: $age, Điểm: $score, Là sinh viên: $isStudent');
  print('Năm sau tuổi sẽ là: ${age + 1}');
}

// -----------------------------------------
// EXERCISE 2: List, Set, Map và Toán tử
// -----------------------------------------
void exercise2() {
  // 1. Làm việc với List (Danh sách)
  List<int> numbers = [5, 10, 15];
  int sum = numbers[0] + numbers[1]; // Toán tử +
  print('Tổng 2 số đầu tiên: $sum');

  // 2. Toán tử so sánh và logic
  bool check = (sum == 15 && numbers[2] > 10);
  print('Kết quả kiểm tra logic: $check');

  // 3. Toán tử ba ngôi (? :)
  String result = check ? 'Đúng rồi' : 'Sai rồi';
  print('Dùng toán tử 3 ngôi: $result');

  // 4. Set (Tập hợp không chứa giá trị trùng nhau)
  Set<String> colors = {'Xanh', 'Đỏ'};
  colors.add('Vàng'); // Thêm vào Set
  colors.remove('Đỏ'); // Xóa khỏi Set
  print('Danh sách màu: $colors');

  // 5. Map (Lưu dữ liệu kiểu Khóa - Giá trị)
  Map<String, String> user = {
    'name': 'Phong',
    'university': 'FPT'
  };
  print('Trường đại học: ${user['university']}');
}

// -----------------------------------------
// EXERCISE 3: If/Else, Switch, Vòng lặp và Hàm
// -----------------------------------------
// Hàm viết kiểu bình thường
int add(int a, int b) {
  return a + b;
}

// Hàm viết kiểu mũi tên (ngắn gọn)
int multiply(int a, int b) => a * b;

void exercise3() {
  // 1. If/Else
  int score = 8;
  if (score >= 5) {
    print('Trạng thái: Đậu môn');
  } else {
    print('Trạng thái: Rớt môn');
  }

  // 2. Switch/Case
  int day = 2;
  switch (day) {
    case 2:
      print('Hôm nay là Thứ 2');
      break;
    default:
      print('Hôm nay là ngày khác');
  }

  // 3. Các loại vòng lặp
  List<String> fruits = ['Táo', 'Cam', 'Chuối'];

  print('Vòng lặp for truyền thống:');
  for (int i = 0; i < fruits.length; i++) {
    print('- ${fruits[i]}');
  }

  print('Vòng lặp for-in:');
  for (String fruit in fruits) {
    print('- $fruit');
  }

  print('Vòng lặp forEach:');
  fruits.forEach((fruit) => print('- $fruit'));

  // 4. Gọi hàm
  print('Gọi hàm cộng (3+4): ${add(3, 4)}');
  print('Gọi hàm nhân (3*4): ${multiply(3, 4)}');
}

// -----------------------------------------
// EXERCISE 4: Lớp (Class) và Kế thừa (Inheritance)
// -----------------------------------------
// Lớp cha
class Animal {
  String name;

  // Constructor cơ bản
  Animal(this.name);

  // Named constructor (Constructor có tên)
  Animal.unknown() : name = 'Chưa có tên';

  void speak() {
    print('$name đang phát ra tiếng kêu');
  }
}

// Lớp con kế thừa lớp cha
class Dog extends Animal {
  // Dùng super để gọi constructor của lớp cha
  Dog(String name) : super(name);

  // Ghi đè hàm của lớp cha
  @override
  void speak() {
    print('$name đang sủa Gâu Gâu');
  }
}

void exercise4() {
  Animal a1 = Animal('Động vật lạ');
  a1.speak();

  Animal a2 = Animal.unknown();
  a2.speak();

  Dog d1 = Dog('Cún cưng');
  d1.speak();
}

// -----------------------------------------
// EXERCISE 5: Bất đồng bộ, Null Safety & Stream
// -----------------------------------------
// Stream: Phát ra dữ liệu sau mỗi khoảng thời gian
Stream<int> countNumbers() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1)); // Đợi 1 giây
    yield i; // Đẩy số i ra
  }
}

Future<void> exercise5() async {
  print('Đang tải dữ liệu (đợi 2 giây)...');
  await Future.delayed(Duration(seconds: 2)); // Giả lập mạng chậm
  print('Tải xong!');

  // Thực hành Null Safety (?, ??, !)
  String? text; // Biến này có thể bị null

  // Dùng ? và ?? (Nếu text null thì lấy độ dài là 0)
  int length1 = text?.length ?? 0;
  print('Độ dài của chuỗi null là: $length1');

  // Dùng ! (Khẳng định biến này chắc chắn KHÔNG null)
  String notNullText = "Hello";
  int length2 = notNullText.length!;
  print('Độ dài chuỗi có chữ là: $length2');

  // Lắng nghe dữ liệu từ Stream
  print('Bắt đầu đếm Stream:');
  await for (int num in countNumbers()) {
    print('Stream nhận được số: $num');
  }
}