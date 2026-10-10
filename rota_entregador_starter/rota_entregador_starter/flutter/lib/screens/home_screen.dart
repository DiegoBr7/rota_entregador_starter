import 'package:flutter/material.dart';
import '../models/entrega.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = ApiService();
  List<Entrega> entregas = [];
  bool carregando = false;

  // Coordenadas de demonstração: substitua pela localização consentida do motorista.
  final double origemLat = -23.5505, origemLon = -46.6333;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    setState(() => carregando = true);
    try {
      final dados = await api.listar();
      if (mounted) setState(() => entregas = dados);
    } catch (e) {
      erro(e);
    } finally {
      if (mounted) setState(() => carregando = false);
    }
  }

  void erro(Object e) {
    if (mounted)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro: $e')));
  }

  Future<void> otimizar() async {
    setState(() => carregando = true);
    try {
      final dados = await api.otimizar(origemLat, origemLon);
      if (mounted) setState(() => entregas = dados);
    } catch (e) {
      erro(e);
    } finally {
      if (mounted) setState(() => carregando = false);
    }
  }

  Future<void> concluir(Entrega e) async {
    try {
      await api.atualizarStatus(e.id, 'CONCLUIDA');
      await carregar();
    } catch (ex) {
      erro(ex);
    }
  }

  Future<void> adicionar() async {
    final nome = TextEditingController(),
        endereco = TextEditingController(),
        lat = TextEditingController(),
        lon = TextEditingController();
    final enviar = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
                title: const Text('Nova entrega'),
                content: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                      controller: nome,
                      decoration:
                          const InputDecoration(labelText: 'Destinatário')),
                  TextField(
                      controller: endereco,
                      decoration: const InputDecoration(labelText: 'Endereço')),
                  TextField(
                      controller: lat,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Latitude')),
                  TextField(
                      controller: lon,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Longitude'))
                ])),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancelar')),
                  FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Salvar'))
                ]));
    if (enviar != true) return;
    final a = double.tryParse(lat.text.replaceAll(',', '.')),
        b = double.tryParse(lon.text.replaceAll(',', '.'));
    if (nome.text.trim().isEmpty ||
        endereco.text.trim().isEmpty ||
        a == null ||
        b == null ||
        a < -90 ||
        a > 90 ||
        b < -180 ||
        b > 180) {
      erro('Confira os campos e coordenadas');
      return;
    }
    try {
      await api.criar(nome.text.trim(), endereco.text.trim(), a, b);
      await carregar();
    } catch (e) {
      erro(e);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Minhas entregas')),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Expanded(
                  child: FilledButton.icon(
                      onPressed: carregando ? null : otimizar,
                      icon: const Icon(Icons.route),
                      label: const Text('Ordenar paradas'))),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: carregando ? null : carregar,
                  icon: const Icon(Icons.refresh))
            ])),
        if (carregando) const LinearProgressIndicator(),
        Expanded(
            child: ListView.builder(
                itemCount: entregas.length,
                itemBuilder: (ctx, i) {
                  final e = entregas[i];
                  return ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text(e.destinatario),
                      subtitle: Text('${e.endereco} • ${e.status}'),
                      trailing: e.status == 'PENDENTE'
                          ? IconButton(
                              icon: const Icon(Icons.check_circle_outline),
                              onPressed: () => concluir(e))
                          : const Icon(Icons.check_circle,
                              color: Colors.green));
                }))
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: adicionar, child: const Icon(Icons.add)));
}
