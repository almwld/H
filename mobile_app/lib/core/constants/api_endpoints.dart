class ApiEndpoints {
  static const String baseUrl = 'https://api.sehtak.com/v1';
  static const String baseUrlDev = 'http://localhost:5000/api';
  
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // User
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String medicalHistory = '/user/medical-history';
  static const String uploadAvatar = '/user/avatar';
  static const String deleteAccount = '/user/account';
  
  // Consultations
  static const String consultations = '/consultations';
  static const String startConsultation = '/consultations/start';
  static const String consultationDetails = '/consultations';
  static const String sendMessage = '/consultations/messages';
  static const String endConsultation = '/consultations/end';
  static const String rateConsultation = '/consultations/rate';
  
  // Doctors
  static const String doctors = '/doctors';
  static const String doctorDetails = '/doctors';
  static const String doctorSchedule = '/doctors/schedule';
  static const String doctorReviews = '/doctors/reviews';
  
  // Pharmacies
  static const String pharmacies = '/pharmacies';
  static const String nearbyPharmacies = '/pharmacies/nearby';
  static const String pharmacyDetails = '/pharmacies';
  static const String pharmacyProducts = '/pharmacies/products';
  
  // Orders
  static const String orders = '/orders';
  static const String orderDetails = '/orders';
  static const String trackOrder = '/orders/track';
  static const String cancelOrder = '/orders/cancel';
  static const String reorder = '/orders/reorder';
  
  // Prescriptions
  static const String prescriptions = '/prescriptions';
  static const String prescriptionDetails = '/prescriptions';
  static const String downloadPrescription = '/prescriptions/download';
  
  // Subscriptions
  static const String subscriptions = '/subscriptions';
  static const String currentSubscription = '/subscriptions/current';
  static const String upgradeSubscription = '/subscriptions/upgrade';
  static const String cancelSubscription = '/subscriptions/cancel';
  static const String plans = '/subscriptions/plans';
  
  // Payments
  static const String payments = '/payments';
  static const String paymentMethods = '/payments/methods';
  static const String addPaymentMethod = '/payments/methods/add';
  static const String removePaymentMethod = '/payments/methods/remove';
  static const String verifyPayment = '/payments/verify';
  
  // AI
  static const String aiTriage = '/ai/triage';
  static const String aiSymptoms = '/ai/symptoms-checker';
  static const String aiChatbot = '/ai/chatbot';
  static const String aiFollowup = '/ai/followup';
  static const String aiPrescription = '/ai/prescription';
  
  // Notifications
  static const String notifications = '/notifications';
  static const String markAsRead = '/notifications/read';
  static const String markAllAsRead = '/notifications/read-all';
  static const String notificationSettings = '/notifications/settings';
}
