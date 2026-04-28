import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/app_colors.dart';
import '../../bloc/consultation/consultation_bloc.dart';
import '../../widgets/consultation_card.dart';
import 'consultation_details_screen.dart';

class ConsultationHistoryScreen extends StatefulWidget {
  const ConsultationHistoryScreen({super.key});

  @override
  State<ConsultationHistoryScreen> createState() => _ConsultationHistoryScreenState();
}

class _ConsultationHistoryScreenState extends State<ConsultationHistoryScreen> {
  late ConsultationBloc _consultationBloc;

  @override
  void initState() {
    super.initState();
    _consultationBloc = GetIt.instance<ConsultationBloc>();
    _consultationBloc.add(LoadConsultationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ConsultationBloc, ConsultationState>(
        bloc: _consultationBloc,
        builder: (context, state) {
          if (state is ConsultationLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ConsultationsLoaded) {
            if (state.consultations.isEmpty) {
              return _buildEmptyState();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.consultations.length,
              itemBuilder: (context, index) {
                return ConsultationCard(
                  consultation: state.consultations[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConsultationDetailsScreen(
                          consultationId: state.consultations[index].id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is ConsultationFailure) {
            return _buildErrorState(state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد استشارات سابقة',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ابدأ استشارتك الأولى الآن',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ابدأ استشارة'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _consultationBloc.add(LoadConsultationsEvent());
            },
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
