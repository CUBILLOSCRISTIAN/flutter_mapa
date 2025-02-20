import 'package:flutter_mapa/feature/auth/domain/entities/user.dart';
import 'package:flutter_mapa/feature/auth/domain/repositories/auth_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  @override
  void onInit() {
    checkAuthStatus();
    super.onInit();
  }
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  final Rx<UserEntity?> _user = Rx<UserEntity?>(null);
  UserEntity? get user => _user.value;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await authRepository.signInWithEmailAndPassword(email, password);
      _user.value = await authRepository.getCurrentUser();
      // NavigationServices.navigateWithGo(Routes.unirseRuta);/
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUp(String email, String password, UserRole role) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await authRepository.signUpWithEmailAndPassword(email, password, role);
      _user.value = await authRepository.getCurrentUser();
      // NavigationServices.navigateWithGo(Routes.unirseRuta);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     isLoading.value = true;
  //     errorMessage.value = '';
  //     await authRepository.signInWithGoogle();
  //     _user.value = await authRepository.getCurrentUser();
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await authRepository.signOut();
      _user.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      _user.value = await authRepository.getCurrentUser();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
