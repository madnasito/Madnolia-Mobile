import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    kotlin("android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.madnolia.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    // Check for key.properties file
    val keyPropertiesFile = rootProject.file("key.properties")
    println("Looking for key.properties at: ${keyPropertiesFile.absolutePath}")
    println("Key properties file exists: ${keyPropertiesFile.exists()}")

    val keyProperties = Properties()
    if (keyPropertiesFile.exists()) {
        FileInputStream(keyPropertiesFile).use { fis ->
            keyProperties.load(fis)
        }
        // Debug: Print the loaded properties (excluding passwords for security)
        println("Loaded keyAlias: ${keyProperties.getProperty("keyAlias")}")
        println("Loaded storeFile path: ${keyProperties.getProperty("storeFile")}")
        println("storeFile exists: ${keyProperties.getProperty("storeFile")?.let { file(it).exists() }}")
    } else {
        println("WARNING: key.properties file not found at ${keyPropertiesFile.absolutePath}")
    }

    signingConfigs {
        create("release") {
            keyAlias = keyProperties.getProperty("keyAlias") ?: ""
            keyPassword = keyProperties.getProperty("keyPassword") ?: ""
            val storeFilePath = keyProperties.getProperty("storeFile")
            if (storeFilePath != null) {
                val storeFileObj = file(storeFilePath)
                if (storeFileObj.exists()) {
                    storeFile = storeFileObj
                    println("Using keystore file: ${storeFileObj.absolutePath}")
                } else {
                    println("ERROR: Keystore file not found: ${storeFileObj.absolutePath}")
                }
            } else {
                println("ERROR: storeFile property is null or not set")
            }
            storePassword = keyProperties.getProperty("storePassword") ?: ""
        }
    }

    defaultConfig {
        applicationId = "com.madnolia.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
}

flutter {
    source = "../.."
}