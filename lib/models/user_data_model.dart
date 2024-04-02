class UserDataModel<T> {
  T? cpf;
  T? name;
  T? age;
  T? userImg;
  T? address;

  UserDataModel({
    this.cpf,
    this.name,
    this.age,
    this.userImg,
    this.address,
  });

  factory UserDataModel.fromMap(Map<String, T> data) {
    return UserDataModel(
      cpf: data['cpf'],
      name: data['name'],
      age: data['age'],
      userImg: data['userImg'],
      address: data['address'],
    );
  }

  Map<String, T?> toMap() {
    return {
      'cpf': cpf,
      'name': name,
      'age': age,
      'userImg': userImg,
      'address': address,
    };
  }
}
