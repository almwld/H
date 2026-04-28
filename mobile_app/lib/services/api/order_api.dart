import '../../core/constants/api_endpoints.dart';
import 'api_client.dart';

class OrderApi {
  final ApiClient _client = ApiClient();

  Future<List<dynamic>> getOrders() async {
    return await _client.get(ApiEndpoints.orders);
  }

  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    return await _client.get('${ApiEndpoints.orderDetails}/$orderId');
  }

  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> data) async {
    return await _client.post(ApiEndpoints.orders, data: data);
  }

  Future<Map<String, dynamic>> trackOrder(String orderId) async {
    return await _client.get('${ApiEndpoints.trackOrder}/$orderId');
  }

  Future<Map<String, dynamic>> cancelOrder(String orderId, {String? reason}) async {
    return await _client.post('${ApiEndpoints.cancelOrder}/$orderId', data: {
      'reason': reason,
    });
  }

  Future<Map<String, dynamic>> reorder(String orderId) async {
    return await _client.post('${ApiEndpoints.reorder}/$orderId');
  }

  Future<List<dynamic>> getPrescriptions() async {
    return await _client.get(ApiEndpoints.prescriptions);
  }

  Future<Map<String, dynamic>> getPrescriptionDetails(String prescriptionId) async {
    return await _client.get('${ApiEndpoints.prescriptionDetails}/$prescriptionId');
  }

  Future<String> downloadPrescription(String prescriptionId) async {
    return await _client.get('${ApiEndpoints.downloadPrescription}/$prescriptionId');
  }
}
