class Patients {
  int id;
  String name;
  String email;

  Patients({this.id, this.name, this.email});

  //setters
  // ignore: unused_element
  set _id(int _id) {
    this.id = _id;
  }

  // ignore: unused_element
  set _name(String _name) {
    this.name = _name;
  }

  // ignore: unused_element
  set _email(String _email) {
    this.email = _email;
  }

//getters
// ignore: unused_element
  int get _id => this.id;
  // ignore: unused_element
  String get _name => this.name;
  // ignore: unused_element
  String get _email => this.email;

  factory Patients.fromJson(Map<String, dynamic> json) {
    return Patients(
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
    );
  }
}
