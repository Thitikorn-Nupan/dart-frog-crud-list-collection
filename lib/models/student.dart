class Student {
  int _sid;
  String _fullname;
  int _age;
  List<String> _skills;

  Student({
    required int sid,
    required String fullname,
    required int age,
    required List<String> skills,
  })  : _sid = sid,
        _fullname = fullname,
        _age = age,
        _skills = skills;
  // pass arg by Student(<key> : <value>, fullname : <value>,...,skills : <value>)

  int get sid => _sid;

  set sid(int value) {
    _sid = value;
  }

  String get fullname => _fullname;

  List<String> get skills => _skills;

  set skills(List<String> value) {
    _skills = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  set fullname(String value) {
    _fullname = value;
  }

  @override
  String toString() {
    return 'Student{ _sid: $_sid, _fullname: $_fullname, _age: $_age, _skills: $_skills}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _sid,
      'fullname': _fullname,
      'age': _age,
      'skills': _skills,
    };
  }
}
