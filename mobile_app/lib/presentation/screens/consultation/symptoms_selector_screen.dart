import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/helpers.dart';
import '../../bloc/consultation/consultation_bloc.dart';
import '../../widgets/custom_button.dart';
import 'active_consultation_screen.dart';

class SymptomsSelectorScreen extends StatefulWidget {
  const SymptomsSelectorScreen({super.key});

  @override
  State<SymptomsSelectorScreen> createState() => _SymptomsSelectorScreenState();
}

class _SymptomsSelectorScreenState extends State<SymptomsSelectorScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  String? _selectedBodyPart;
  String _selectedType = 'chat';
  late ConsultationBloc _consultationBloc;

  final Map<String, String> bodyParts = {
    'head': 'الرأس',
    'chest': 'الصدر',
    'abdomen': 'البطن',
    'back': 'الظهر',
    'arm': 'الذراع',
    'leg': 'الساق',
    'neck': 'الرقبة',
    'ear': 'الأذن',
    'eye': 'العين',
  };

  final Map<String, String> consultationTypes = {
    'chat': 'محادثة نصية',
    'audio': 'مكالمة صوتية',
    'video': 'مكالمة فيديو',
  };

  @override
  void initState() {
    super.initState();
    _consultationBloc = GetIt.instance<ConsultationBloc>();
  }

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.newConsultation)),
      body: BlocListener<ConsultationBloc, ConsultationState>(
        bloc: _consultationBloc,
        listener: (context, state) {
          if (state is ConsultationLoading) {
            Helpers.showLoadingDialog(context);
          } else {
            Helpers.hideLoadingDialog(context);
          }
          if (state is ConsultationStarted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ActiveConsultationScreen(
                  consultationId: state.consultation.id,
                ),
              ),
            );
          }
          if (state is ConsultationFailure) {
            Helpers.showSnackBar(context, state.message, isError: true);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.bodyPart,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: bodyParts.entries.map((entry) {
                  return FilterChip(
                    label: Text(entry.value),
                    selected: _selectedBodyPart == entry.key,
                    onSelected: (selected) {
                      setState(() {
                        _selectedBodyPart = selected ? entry.key : null;
                      });
                    },
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    checkmarkColor: AppColors.primary,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.symptoms,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _symptomsController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'مثال: أعاني من ألم حاد في البطن مع غثيان وارتفاع في درجة الحرارة...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.consultationType,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: consultationTypes.entries.map((entry) {
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          entry.key == 'chat'
                              ? Icons.chat
                              : entry.key == 'audio'
                              ? Icons.mic
                              : Icons.videocam,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(entry.value),
                      ],
                    ),
                    selected: _selectedType == entry.key,
                    onSelected: (selected) {
                      setState(() {
                        _selectedType = selected ? entry.key : _selectedType;
                      });
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: _selectedType == entry.key ? Colors.white : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: AppStrings.startConsultation,
                onPressed: _startConsultation,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _startConsultation() {
    if (_symptomsController.text.isEmpty) {
      Helpers.showSnackBar(
        context,
        'الرجاء كتابة الأعراض',
        isError: true,
      );
      return;
    }

    _consultationBloc.add(
      StartConsultationEvent(
        symptoms: _symptomsController.text,
        bodyPart: _selectedBodyPart,
        preferredType: _selectedType,
      ),
    );
  }
}
