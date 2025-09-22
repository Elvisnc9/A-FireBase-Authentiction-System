# 🔐 Firebase Live Authentication System  

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)
![Riverpod](https://img.shields.io/badge/Riverpod-0C7A43?logo=flutter&logoColor=white)
![Biometrics](https://img.shields.io/badge/Biometrics-FaceID%2FFingerprint-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

A modern **Flutter Authentication System** powered by **Firebase**, **Riverpod**, and **Biometrics**.  
This project demonstrates how to integrate **secure user login flows** with:  

- 📱 **Biometric Authentication** (Fingerprint / FaceID)  
- 🌐 **Social Sign-In** (Google, Facebook, etc.)  
- 🔥 **Firebase Authentication** for email/password and token management  
- 🪝 **Riverpod** for clean state management  
- 🎨 A polished & responsive UI  

---

## 🚀 Features  

- **Email & Password Authentication** (Firebase Auth)  
- **Google Sign-In** (via `google_sign_in`)  
- **Apple Sign-In** (iOS/macOS only)  
- **Biometric Authentication** (Fingerprint/FaceID using `local_auth`)  
- **State Management with Riverpod** (clean & reactive auth flows)  
- **Persistent Sessions** (auto-login with secure storage)  
- **Responsive Design** (works on Android, iOS, and Web)  

---

## 🛠️ Tech Stack  

- **Flutter** (Frontend)  
- **Firebase Auth** (Backend Authentication)  
- **Riverpod** (State management)  
- **Local Auth** (Biometric authentication)  
- **Google Sign-In SDK**    

---

## 📂 Project Structure  

```bash
lib/
│── constants/               # Entry point
│── provider/                # Riverpod providers
│── services/             # Firebase & Auth services
│── pages/                      # Screens & widgets
│   ├── AuthForm.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── Onboarding_screen.dart
│   └── HomeScreen.dart
│── main.dart                    # Helpers & constants
