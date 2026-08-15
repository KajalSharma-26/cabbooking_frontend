class SignupRequest {
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;

  SignupRequest({this.name, this.email, this.password, this.confirmPassword});

  SignupRequest copyWith({String? name, String? email, String? password, String? confirmPassword}) {
    return SignupRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'confirmPassword': confirmPassword};
  }
}

class LoginRequest {
  final String? email;
  final String? password;

  LoginRequest({this.email, this.password});

  LoginRequest copyWith({String? email, String? password}) {
    return LoginRequest(email: email ?? this.email, password: password ?? this.password);
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(email: json['email'] as String?, password: json['password'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
