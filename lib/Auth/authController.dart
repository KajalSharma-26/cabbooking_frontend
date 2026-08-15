import 'package:cabbooking_frontend/Auth/authModel.dart';
import 'package:cabbooking_frontend/apiClient.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authcontroller extends GetxController {
  final ApiClient _apiClient = ApiClient();
  late SharedPreferences sharedPreferences;

  SignupRequest? signupRequest;
  LoginRequest? loginRequest;

  final isLoading = false.obs;
  final userName = ''.obs;
  final userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;

      signupRequest = SignupRequest(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      final response = await _apiClient.postData(
        '/api/signup',
        signupRequest!.toJson(),
      );

      if (response['token'] != null) {
        await sharedPreferences.setString('token', response['token']);
      }

      _saveUserFromResponse(response, fallbackName: name, fallbackEmail: email);

      Get.snackbar(
        'Success',
        response['message'] ?? 'Account created successfully',
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      loginRequest = LoginRequest(email: email, password: password);

      final response = await _apiClient.postData(
        '/api/login',
        loginRequest!.toJson(),
      );
      print(response);
      if (response['token'] != null) {
        await sharedPreferences.setString('token', response['token']);
      }

      _saveUserFromResponse(response, fallbackEmail: email);

      Get.snackbar('Success', response['message'] ?? 'Login successful');
      return true;
    } catch (e) {
      print(e);
      Get.snackbar(
        'Login Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _saveUserFromResponse(
    Map<String, dynamic> response, {
    String? fallbackName,
    String? fallbackEmail,
  }) {
    final user = response['user'];
    final name = user is Map
        ? user['name']?.toString()
        : response['name']?.toString();
    final email = user is Map
        ? user['email']?.toString()
        : response['email']?.toString();

    userName.value = (name ?? fallbackName ?? '').trim();
    userEmail.value = (email ?? fallbackEmail ?? '').trim();

    if (userName.value.isNotEmpty) {
      sharedPreferences.setString('userName', userName.value);
    }
    if (userEmail.value.isNotEmpty) {
      sharedPreferences.setString('userEmail', userEmail.value);
    }
  }

  Future<void> logout() async {
    await sharedPreferences.remove('token');
    await sharedPreferences.remove('userName');
    await sharedPreferences.remove('userEmail');
    userName.value = '';
    userEmail.value = '';
  }
}
