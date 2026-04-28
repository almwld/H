import '../../core/constants/api_endpoints.dart';
import 'api_client.dart';

class PharmacyApi {
  final ApiClient _client = ApiClient();

  Future<List<dynamic>> getPharmacies() async {
    return await _client.get(ApiEndpoints.pharmacies);
  }

  Future<List<dynamic>> getNearbyPharmacies(double lat, double lng) async {
    return await _client.get(ApiEndpoints.nearbyPharmacies, queryParams: {
      'lat': lat,
      'lng': lng,
    });
  }

  Future<Map<String, dynamic>> getPharmacyDetails(String pharmacyId) async {
    return await _client.get('${ApiEndpoints.pharmacyDetails}/$pharmacyId');
  }

  Future<List<dynamic>> getPharmacyProducts(String pharmacyId) async {
    return await _client.get('${ApiEndpoints.pharmacyProducts}/$pharmacyId');
  }

  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    return await _client.get('${ApiEndpoints.pharmacyProducts}/$productId');
  }

  Future<Map<String, dynamic>> searchProducts(String query) async {
    return await _client.get('${ApiEndpoints.pharmacyProducts}/search', queryParams: {
      'q': query,
    });
  }
}
