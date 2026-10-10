class Entrega {
  final int id;
  final String destinatario, endereco, status;
  final double latitude, longitude;

  Entrega(
      {required this.id,
      required this.destinatario,
      required this.endereco,
      required this.status,
      required this.latitude,
      required this.longitude});

  factory Entrega.fromJson(Map<String, dynamic> j) => Entrega(
      id: j['id'] as int,
      destinatario: j['destinatario'] as String,
      endereco: j['endereco'] as String,
      status: j['status'] as String,
      latitude: (j['latitude'] as num).toDouble(),
      longitude: (j['longitude'] as num).toDouble());
}
