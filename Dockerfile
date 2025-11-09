# Stage 1: Setup Flutter, build web and APK
FROM --platform=linux/amd64 ubuntu:22.04 AS build

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
    flutter precache --android --web && \
    flutter config --enable-web

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
    sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

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

# Enable web and build APK and Web
RUN flutter config --enable-web
RUN flutter build apk --release
RUN flutter build web --release

# Stage 2: Create the runtime image with a web server
FROM nginx:1.25-alpine AS runtime

# Copy the web build output from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy the APK from the build stage to a location for easy retrieval
COPY --from=build /app/build/app/outputs/flutter-apk/app-release.apk /usr/share/nginx/html/app-release.apk

# Expose port 80 for the web server
EXPOSE 80

# The nginx image will automatically start the server
CMD ["nginx", "-g", "daemon off;"]
