import 'package:dio/dio.dart';
import '../models/entrega.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment('API_URL',
          defaultValue: 'http://10.0.2.2:8080/api')));

  Future<List<Entrega>> listar() async {
    final r = await _dio.get('/entregas');
    return (r.data as List).map((e) => Entrega.fromJson(e)).toList();
  }

  Future<void> criar(
          String nome, String endereco, double lat, double lon) async =>
      _dio.post('/entregas', data: {
        'destinatario': nome,
        'endereco': endereco,
        'latitude': lat,
        'longitude': lon
      });

  Future<List<Entrega>> otimizar(double lat, double lon) async {
    final r = await _dio
        .post('/rotas/otimizar', data: {'latitude': lat, 'longitude': lon});
    return (r.data as List).map((e) => Entrega.fromJson(e)).toList();
  }

  Future<void> atualizarStatus(int id, String status) async =>
      _dio.patch('/entregas/$id/status', queryParameters: {'valor': status});
}
