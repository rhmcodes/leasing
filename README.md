# NSS Dealer

<p>
  <img src="assets/readme/overview.png" alt="NSS Dealer Banner" width="100%" />
</p>

**NSS Dealer** is a motorcycle dealer application for **PT. Nusantara Sakti Group**.

The platform delivers a clean experience for motorcycle catalog browsing, product details, promotions, financing simulation, credit application, booking, test ride, dealer locations, after-sales service, and customer support.

NSS Dealer supports digital transformation by improving product accessibility, customer engagement, financing support, transaction readiness, dealer visibility, operational efficiency, and motorcycle sales support.

---

## Key Features

| Feature                | Description                                                                                  |
|------------------------|----------------------------------------------------------------------------------------------|
| Motorcycle Catalog     | Display motorcycle products in a structured and easy-to-browse catalog.                      |
| Product Detail         | Provide detailed motorcycle information, variants, colors, prices, and specifications.       |
| Promotion Management   | Display active promotions, promotional banners, and campaign details.                        |
| Financing Simulation   | Help users estimate down payment, tenor, and monthly installment options.                    |
| Credit Application     | Prepare credit application workflows for motorcycle financing.                               |
| Booking Management     | Support booking workflows for selected motorcycle products.                                  |
| Test Ride Request      | Allow users to submit test ride requests through the application.                            |
| Dealer Location        | Display dealer branch information and location access.                                       |
| Customer Support       | Provide FAQ, customer service, and support ticket workflows.                                 |
| Profile Management     | Manage user profile, settings, and account-related information.                              |

---

## Technology Stack

### Tooling & Platform

| Technology             |     Version | Purpose                                             |
|------------------------|------------:|-----------------------------------------------------|
| App Version            |   `1.0.0+1` | Application version and build number.               |
| Flutter                |    `3.41.9` | Cross-platform mobile application framework.        |
| Flutter SDK Constraint |  `>=3.35.0` | Minimum Flutter SDK recorded in `pubspec.lock`.     |
| Dart SDK               |    `3.11.5` | Main programming language for Flutter development.  |
| Dart SDK Constraint    |   `^3.11.5` | SDK constraint declared in `pubspec.yaml`.          |
| DevTools               |    `2.54.2` | Flutter development and debugging tools.            |
| Android SDK            |    `37.0.0` | Android development toolkit.                        |
| Android Build Tools    |    `37.0.0` | Android SDK build tools.                            |
| Android Emulator       | `36.5.11.0` | Android virtual device runtime.                     |
| Java JDK               |   `17.0.19` | Java runtime configured for Flutter Android builds. |
| Android Gradle Plugin  |     `9.2.0` | Android build system plugin.                        |
| Kotlin Gradle Plugin   |    `2.3.20` | Android platform language and Gradle integration.   |
| Gradle Wrapper         |     `9.5.1` | Build automation and dependency management.         |
| JVM Target             |        `17` | Java compatibility target for Kotlin compilation.   |

### Flutter Dependencies

| Package          |    Version | Purpose                                      |
|------------------|-----------:|----------------------------------------------|
| cupertino_icons  |    `1.0.9` | Cupertino icon font support.                 |
| dio              |    `5.9.2` | HTTP client and network requests.            |
| intl             |   `0.20.2` | Date, number, and currency formatting.       |
| flutter_bloc     |    `9.1.1` | State management with Bloc/Cubit patterns.   |
| go_router        |   `17.2.3` | Declarative app routing.                     |
| flutter_lints    |    `6.0.0` | Recommended static analysis lint rules.      |
| flutter_test     |      `SDK` | Flutter widget and unit testing framework.   |

---

## Build Configuration

Several build configuration updates were applied to improve compatibility, stability, and build reliability.

| File                        | Configuration                                   | Notes                                                                   |
|-----------------------------|-------------------------------------------------|-------------------------------------------------------------------------|
| `settings.gradle.kts`       | `com.android.application` version `9.2.0`       | Android Gradle Plugin configured to version `9.2.0`.                    |
| `gradle-wrapper.properties` | Gradle `9.5.1`                                  | Gradle wrapper configured to version `9.5.1`.                           |
| `build.gradle.kts`          | Java compatibility `17`                         | Source and target compatibility use Java 17.                            |
| `build.gradle.kts`          | Kotlin compiler DSL                             | Replaced deprecated `kotlinOptions` with the new `compilerOptions` DSL. |
| `gradle.properties`         | Kotlin daemon configuration                     | Added configuration to improve Windows build stability.                 |

### Kotlin Compiler DSL

The previous Kotlin configuration:

```kotlin
kotlinOptions {
    jvmTarget = JavaVersion.VERSION_17.toString()
}
```

The recommended Kotlin configuration:

```kotlin
kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}
```
