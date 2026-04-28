import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../data/datasources/remote/api_service.dart';
import '../../../data/models/consultation_model.dart';

// Events
abstract class ConsultationEvent {}
class LoadConsultationsEvent extends ConsultationEvent {}
class StartConsultationEvent extends ConsultationEvent {
  final String symptoms;
  final String? bodyPart;
  final String preferredType;
  StartConsultationEvent({required this.symptoms, this.bodyPart, required this.preferredType});
}
class LoadConsultationEvent extends ConsultationEvent {
  final String id;
  LoadConsultationEvent(this.id);
}
class SendMessageEvent extends ConsultationEvent {
  final String consultationId;
  final String content;
  SendMessageEvent({required this.consultationId, required this.content});
}
class EndConsultationEvent extends ConsultationEvent {
  final String consultationId;
  EndConsultationEvent(this.id);
}

// States
abstract class ConsultationState {}
class ConsultationInitial extends ConsultationState {}
class ConsultationLoading extends ConsultationState {}
class ConsultationsLoaded extends ConsultationState {
  final List<ConsultationModel> consultations;
  ConsultationsLoaded(this.consultations);
}
class ConsultationLoaded extends ConsultationState {
  final ConsultationModel consultation;
  final List<Map<String, dynamic>> messages;
  ConsultationLoaded(this.consultation, this.messages);
}
class ConsultationStarted extends ConsultationState {
  final ConsultationModel consultation;
  ConsultationStarted(this.consultation);
}
class ConsultationFailure extends ConsultationState {
  final String message;
  ConsultationFailure(this.message);
}

// BLoC
class ConsultationBloc extends Bloc<ConsultationEvent, ConsultationState> {
  final ApiService _apiService = GetIt.instance<ApiService>();

  ConsultationBloc() : super(ConsultationInitial()) {
    on<LoadConsultationsEvent>(_onLoadConsultations);
    on<StartConsultationEvent>(_onStartConsultation);
    on<LoadConsultationEvent>(_onLoadConsultation);
    on<SendMessageEvent>(_onSendMessage);
    on<EndConsultationEvent>(_onEndConsultation);
  }

  Future<void> _onLoadConsultations(LoadConsultationsEvent event, Emitter<ConsultationState> emit) async {
    emit(ConsultationLoading());
    try {
      final consultations = await _apiService.getConsultations();
      emit(ConsultationsLoaded(consultations));
    } catch (e) {
      emit(ConsultationFailure(e.toString()));
    }
  }

  Future<void> _onStartConsultation(StartConsultationEvent event, Emitter<ConsultationState> emit) async {
    emit(ConsultationLoading());
    try {
      final consultation = await _apiService.startConsultation({
        'symptoms': event.symptoms,
        'bodyPart': event.bodyPart,
        'preferredType': event.preferredType,
      });
      emit(ConsultationStarted(consultation));
    } catch (e) {
      emit(ConsultationFailure(e.toString()));
    }
  }

  Future<void> _onLoadConsultation(LoadConsultationEvent event, Emitter<ConsultationState> emit) async {
    emit(ConsultationLoading());
    try {
      final consultation = await _apiService.getConsultationDetails(event.id);
      emit(ConsultationLoaded(consultation, []));
    } catch (e) {
      emit(ConsultationFailure(e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ConsultationState> emit) async {
    try {
      await _apiService.sendMessage(event.consultationId, event.content);
    } catch (e) {
      emit(ConsultationFailure(e.toString()));
    }
  }

  Future<void> _onEndConsultation(EndConsultationEvent event, Emitter<ConsultationState> emit) async {
    emit(ConsultationLoading());
    try {
      emit(ConsultationInitial());
    } catch (e) {
      emit(ConsultationFailure(e.toString()));
    }
  }
}
