import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

android {
    namespace = "com.almawasi.name"
    compileSdk = flutter.compileSdkVersion
//    ndkVersion = flutter.ndkVersion
    ndkVersion = "29.0.13113456"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        // Add this line:
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.almawasi.name"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
                ?: error("Missing keyAlias in android/key.properties")
            keyPassword = keystoreProperties.getProperty("keyPassword")
                ?: error("Missing keyPassword in android/key.properties")
            storeFile = rootProject.file(
                keystoreProperties.getProperty("storeFile")
                    ?: error("Missing storeFile in android/key.properties"),
            )
            storePassword = keystoreProperties.getProperty("storePassword")
                ?: error("Missing storePassword in android/key.properties")
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
    }
}
dependencies {
    // Add this line for desugaring:
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
flutter {
    source = "../.."
}
