import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../data/datasources/remote/api_service.dart';
import '../../../data/datasources/local/storage_service.dart';

// Events
abstract class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}
class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String userType;
  RegisterRequested({required this.name, required this.email, required this.phone, required this.password, required this.userType});
}
class LoadProfileEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent {}

// States
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class ProfileLoaded extends AuthState {
  final Map<String, dynamic> user;
  ProfileLoaded(this.user);
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService _apiService = GetIt.instance<ApiService>();
  final StorageService _storageService = GetIt.instance<StorageService>();

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LoadProfileEvent>(_onLoadProfile);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _apiService.login(event.email, event.password);
      await _storageService.saveToken(response['token']);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _apiService.register({
        'name': event.name,
        'email': event.email,
        'phone': event.phone,
        'password': event.password,
        'userType': event.userType,
      });
      await _storageService.saveToken(response['token']);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoadProfile(LoadProfileEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await _apiService.getProfile();
      emit(ProfileLoaded(user.toJson()));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _storageService.clearAll();
    emit(AuthInitial());
  }
}
