import 'package:pr4/pr4.dart' as pr4;

void main(List<String> arguments) {
  Person person = new Person();
  person.drink();
}
//1
class Cup{
  
  void drink(){
    print('я пью из кружки');
  }
}

class Person extends Cup{
  void breath(){
    print("я дышу");
  }
  void drink(){
    super.drink();
  }
}

//2
class Wardrobe{
  String clothe;
  Wardrobe(this.clothe);
  List<String> shelf =[];
  List<String> trempel =[];
  
  void inShelf(String clothe){ shelf.add(clothe);}
  void outShelf(String clothe){ shelf.remove(clothe);}
  void inTrempel(String clothe){ trempel.add(clothe);}
  void outTrempel(String clothe){ trempel.remove(clothe);}
  void showAll(){
    print("на тремпелях:");
    for(var c in trempel){print(c);}
    print("на полках:");
    for(var c in shelf){print(c);}
  }

}

//3
class Blin{
  int weigth;
  int num;
  Blin(this.num, this.weigth);
  
}
class Grif{
  int maxLoad;
  List<Blin> leftSide = [];
  List<Blin> rightSide = [];
  Grif(this.maxLoad);
  void putLeft(Blin blin){
    if(blin.weigth*blin.num > maxLoad/2){
      print("слишком большая нагрузка на гриф");
    } leftSide.add(blin);
  }
  void putRight(Blin blin){
    if(blin.weigth*blin.num > maxLoad/2){
      print("слишком большая нагрузка на гриф");
    } rightSide.add(blin);
    isBalanced();
  }
  bool isBalanced() {
    double leftTotal = 0;
    for (Blin b in leftSide) {
      leftTotal += b.weigth * b.num;
    }
    
    double rightTotal = 0;
    for (Blin b in rightSide) {
      rightTotal += b.weigth * b.num;
    }
    
    print("Левая сторона: ${leftTotal}кг");
    print("Правая сторона: ${rightTotal}кг");
    
    if (leftTotal == rightTotal) {
      print("Вес одинаковый");
    } else {
      String heavier = leftTotal > rightTotal ? "левая" : "правая";
      print("Перевес на ${heavier} стороне");
    }
    
    return leftTotal == rightTotal;
  }
}

//4


//11
abstract class Table{
  void take();
  void remove();
}

class Spoon implements Table{
  @override
  void take(){
    print("Ложка на столе");
  }
  @override
  void remove(){
    print("ложку убрали со стола");
  }
}
//10
class Shape{
  String figure;
  int size;
  Shape(this.figure, this.size);
  List<Shape> shapes = [];
  void add(Shape shape){
    shapes.add(shape);
  }
  void maxShape(){
    Shape max = shapes[0];
    for(var shape in shapes){
      if(shape.size > max.size){max=shape;}
    }
    print("${max.figure} ${max.size}");
  }
  
}

//9
class Systems{
  String toHex(value){
    String result = value.toRadixString(16);
    return result;
  }
  String toOct(value){
    String result = value.toRadixString(8);
    return result;
  }
  String toDec(value){
    String result = value.toRadixString(10);
    return result;
  }
}

//8
abstract class GeoFigure{
  double Square(double a, int b);
  double Perimetre(double a, int b);
}

class Rectangle implements GeoFigure{
  @override
  double Square(double a, int b){
    return a*b;
  }
  @override
  double Perimetre(double a, int b){ return (a+b)*2;}
}
class Triangle implements GeoFigure{
  @override
  double Square(double a, int b){
    return (a*b)/2;
  }
  @override
  double Perimetre(double a, int b){ return 2*a+b;}
}

//7
enum ToDo{
    stop, go, turn
  }
class Car{
  void options(ToDo todo){
    switch(todo){
      case ToDo.stop:stop();break;
      case ToDo.go: go();break;
      case ToDo.turn: turn();break;
    }
    
  }
  void stop(){
    print("машина остановилась");
  }
  void go(){
    print("машина едет");
  }
  void turn(){
    print("машина поворачивает");
}
}
//6
