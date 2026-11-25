# Objave

Jednostavna Flutter aplikacija koja dohvaća popis objava s javnog API-ja
[JSONPlaceholder](https://jsonplaceholder.typicode.com/posts). Na početnom
ekranu prikazuje objave, a odabirom objave otvara se ekran s detaljima.

## Struktura projekta

- `lib/main.dart` – pokretanje aplikacije i tema.
- `lib/models/post.dart` – model objave i pretvorba JSON zapisa.
- `lib/services/post_service.dart` – asinkroni dohvat podataka.
- `lib/screens/list_screen.dart` – popis objava, `FutureBuilder`,
  `ListView.builder` i osvježavanje.
- `lib/screens/detail_screen.dart` – detalji odabrane objave i animacija.
- `lib/widgets/post_tile.dart` – prikaz pojedine objave.
- `lib/screens/home_screen.dart` – početni ekran.

## Animacije i geste

- `Hero` animacija prijelaza broja objave nalazi se u
  `lib/widgets/post_tile.dart` i `lib/screens/detail_screen.dart`.
- `ScaleTransition` animacija na ekranu detalja nalazi se u
  `lib/screens/detail_screen.dart`. `AnimationController` se oslobađa
  metodom `dispose()`.
- `AnimatedScale` animacija oznake nalazi se u `lib/widgets/post_tile.dart`.
- Povlačenje prema dolje za osvježavanje popisa (`RefreshIndicator`) nalazi se
  u `lib/screens/list_screen.dart`.
- Dugi pritisak na objavu označava ili uklanja oznaku. Gesta je povezana u
  `lib/widgets/post_tile.dart`, a obrađena u `lib/screens/list_screen.dart`.

## Pokretanje

1. Instaliraj Flutter i pripremi emulator ili priključi uređaj.
2. Otvori mapu projekta u Visual Studio Codeu ili terminalu.
3. Pokreni `flutter pub get`.
4. Pokreni `flutter run`.

Za provjeru koda pokreni `flutter analyze`.
