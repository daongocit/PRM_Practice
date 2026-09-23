// TODO 1: Định nghĩa class Vehicle với các thuộc tính String brand, int year.
// Viết Default constructor và hàm void startEngine().
class Vehicle {
  String brand;
  int year;

  // Default Constructor
  Vehicle(this.brand, this.year);

  // Phương thức startEngine
  void startEngine() {
    print("Khởi động phương tiện...");
  }
}

// TODO 2: Định nghĩa class Car kế thừa từ Vehicle.
// Thêm thuộc tính bool isElectric.
class Car extends Vehicle {
  bool isElectric;

  // TODO 3: Viết constructor mặc định cho Car (dùng super để truyền brand và year).
  Car(String brand, int year, this.isElectric) : super(brand, year);

  // Viết Named Constructor: Car.tesla(int year) thiết lập sẵn brand="Tesla" và isElectric=true.
  Car.tesla(int year)
      : isElectric = true,
        super("Tesla", year);

  // TODO 4: Ghi đè (@override) hàm startEngine() để in ra thông báo chi tiết hơn.
  @override
  void startEngine() {
    if (isElectric) {
      print("$brand ($year): Khởi động êm ái, không có tiếng ồn (Xe điện).");
    } else {
      print("$brand ($year): Khởi động động cơ nổ Vrooom! (Xe động cơ đốt trong).");
    }
  }
}

void main() {
  // TODO 5: Khởi tạo một xe Car bình thường và gọi startEngine()
  Car normalCar = Car("Toyota Vios", 2021, false);
  normalCar.startEngine();
}