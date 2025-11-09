# Stage 1: Setup Flutter and Android SDK
FROM ubuntu:22.04 AS build

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-17-jdk \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
ENV FLUTTER_HOME=/opt/flutter
ENV FLUTTER_VERSION=3.24.4
ENV PATH="${FLUTTER_HOME}/bin:${PATH}"

RUN git clone --depth 1 --branch ${FLUTTER_VERSION} \
    https://github.com/flutter/flutter.git ${FLUTTER_HOME} && \
    flutter doctor -v && \
    flutter precache --android --linux && \
    flutter config --enable-linux-desktop

# Install Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/build-tools/34.0.0:${PATH}"

RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    cd ${ANDROID_SDK_ROOT}/cmdline-tools && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip -q commandlinetools-linux-9477386_latest.zip && \
    rm commandlinetools-linux-9477386_latest.zip && \
    mv cmdline-tools latest && \
    yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" "ndk;25.1.8937393"

# Configure Flutter to use Android SDK
RUN flutter config --android-sdk ${ANDROID_SDK_ROOT} && \
    flutter doctor -v

# Build application
WORKDIR /app

# Copy pubspec files for caching
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy rest of the project
COPY . .

# Validate pubspec.yaml fonts exist (optional but recommended)
RUN if grep -q "fonts:" pubspec.yaml; then \
      echo "Checking font files..."; \
      grep -A 20 "fonts:" pubspec.yaml | grep "asset:" | sed 's/.*asset: //' | sed 's/"//g' | while read font; do \
        if [ ! -f "$font" ]; then \
          echo "Warning: Font file not found: $font"; \
        fi; \
      done; \
    fi

# Create gradle.properties to limit memory usage
RUN mkdir -p android && \
    echo "org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g -XX:+HeapDumpOnOutOfMemoryError" > android/gradle.properties && \
    echo "org.gradle.daemon=true" >> android/gradle.properties && \
    echo "org.gradle.parallel=true" >> android/gradle.properties && \
    echo "org.gradle.workers.max=4" >> android/gradle.properties && \
    echo "android.useAndroidX=true" >> android/gradle.properties

# Build APK with optimized settings
RUN flutter build apk --release --verbose