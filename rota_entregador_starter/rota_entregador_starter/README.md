# Rotas para entregadores — MVP

Projeto inicial: Flutter + Java Spring Boot + PostgreSQL.

## Executar

1. Instale JDK 21, Maven, Flutter, Docker Desktop.
2. Na raiz, execute `docker compose up -d`.
3. Em `backend/`, execute `mvn spring-boot:run`.
4. Crie um projeto Flutter completo com `flutter create rotas_app` e copie para ele o `pubspec.yaml` e a pasta `lib/` deste pacote.
5. Dentro de `rotas_app/`, execute `flutter pub get` e `flutter run` (emulador Android).
6. Se necessário, habilite INTERNET em `android/app/src/main/AndroidManifest.xml` e para desenvolvimento HTTP local configure `android:usesCleartextTraffic="true"` no elemento `application`. Em produção, use HTTPS.
7. O endereço `10.0.2.2` acessa o computador host pelo emulador Android. No aparelho físico, configure `--dart-define=API_URL=http://IP_LOCAL:8080/api` e libere a porta na rede local.

## Endpoints
- `GET /api/entregas`
- `POST /api/entregas` com `{"destinatario":"Ana","endereco":"Praça da Sé, São Paulo","latitude":-23.5505,"longitude":-46.6333}`
- `PATCH /api/entregas/1/status?valor=CONCLUIDA`
- `POST /api/rotas/otimizar` com `{"latitude":-23.5505,"longitude":-46.6333}`

## Limitações intencionais
O algoritmo é vizinho mais próximo com distância em linha reta, **não** calcula percurso real nas ruas e **não** garante rota globalmente ótima. Ainda não há geocodificação, mapa, login, autorização, isolamento de dados por motorista, rastreamento GPS ou cobrança. Coordenadas e origem são manuais/de demonstração. Não publique como serviço aberto sem autenticação, migrações e HTTPS. `ddl-auto=update` é somente para desenvolvimento.
