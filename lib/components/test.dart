import 'package:equatable/equatable.dart';

/* class Test extends Equatable {
  static final Test _instances = Test._internl(Test._instances.test);
  final String test;

  factory Test(String s) {
    return _instances;
  }

  Test._internl(this.test);

  @override
  // TODO: implement props
  List<Object?> get props => [test];
}
 */

/* class Test extends Equatable {
  static final Test _singleton = Test._internal();
  late  String test;

  factory Test() {
    print("factory");
    return _singleton;
  }

  static Test get instance => _singleton;

  void setVariab({required String ts}) {
    print(ts);
    ts = test;
  }

  Test._internal() {
   // test = 'Test';
    setVariab(ts: '');
  }

  @override
  // TODO: implement props
  List<Object> get props => [test];
}
 */

class Test extends Equatable {
  static Test _instance = Test._internal();
  String first = '';
  String second = '';

  Test._internal() {
    _instance = this;
    _instance.first = first;
    _instance.second = second;

    setMthod(s: _instance.first, f: _instance.second);
  }

  void setMthod({required String f, required String s}) {
    _instance.second = s;
    _instance.first = f;
  }

  void open() {
    // print("open method");
    print("${first}" "${second}");
  }

  factory Test() => _instance;

  @override
  // TODO: implement props
  List<Object?> get props => [first, second];
}

class Peoples {
  late int id;
  late String name;

  static final Peoples _inst = Peoples._internal();

  Peoples._internal();

  factory Peoples(int id, String name) {
    _inst.id = id;
    _inst.name = name;
    print(id);
    print(name);
    print(_inst.name);
    if (_inst.id != id && _inst.name != name) {
      print("true");
      return _inst;
    } else {
      print("false");
      return _inst;
    }
  }
  void open() {
    // print("open method");
    print("${_inst.id}" "${_inst.name}");
  }
}
