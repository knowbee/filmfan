# FILMFAN

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Filmfan works on iOS, Android, Web, and Windows._

---

## Preview (Screenshots)

<img src="./images/home.png" height="400" alt="Home screenshot"> <img src="./images/details.png" height="400" alt="Movie details screen">
<img src="./images/recommended.png" height="400" alt="Recommended movies"> <img src="./images/favorites.png" height="400" alt="Favorites page">
<img src="./images/searchpage.png" height="400" alt="Search page">
<img src="./images/search.png" height="400" alt="Search results">

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Libraries

- bloc
- dio
- mockingjay
- mocktail
- localstorage
- flutter_bloc
- carousel_slider
