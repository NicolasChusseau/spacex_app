# SpaceX App

Objective

SpaceX App is an educational Flutter application that consumes the public SpaceX API (v4) to list launches and show launch details. The details view includes essential information about the rocket used by a launch. The app also supports marking launches as favorites and includes a first-run onboarding.

How to run the app

1. Prerequisites
   - Install Flutter (see the SDK constraint in `pubspec.yaml`).
   - Have an Android or iOS device or emulator available.

2. Install dependencies

```bash
flutter pub get
```

3. (Optional) Generate model serialization code

If you edit models annotated with `json_serializable`, generate the `.g.dart` files:

```bash
flutter pub run build_runner build
```

4. Run the application

```bash
flutter run
```

