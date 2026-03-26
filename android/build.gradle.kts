buildscript {
    repositories {
        google()
        mavenCentral()
         maven {
             url = uri("${rootProject.projectDir}/local-zoom-repo")
             content {
                 includeGroupByRegex("us\\.zoom.*")
             }
         }
        // maven { url = uri("https://maven.zoom.us/repo") }
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("${rootProject.projectDir}/local-zoom-repo")
            content {
                includeGroupByRegex("us\\.zoom.*")
            }
        }
        // maven { url = uri("https://maven.zoom.us/repo") }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = "17"
        targetCompatibility = "17"
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
