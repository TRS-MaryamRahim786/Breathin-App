
# Breathin-App

## Getting Started

## Breathin App

## Description
Breathin App is a Flutter application that allows users to select their preferred language and provides secure login and signup functionality using Firebase Firestore. The app is designed to offer a seamless user experience with multilingual support and robust authentication features.

## Features
- **Language Selection:** Users can choose their preferred language at the start of the app.
- **User Authentication:** Secure login and signup using Firebase Firestore.
- **Email and Password Authentication:** Ensures secure access to the app.
- **User-Friendly Interface:** Intuitive and easy-to-use interface for a better user experience.
- **Sound Management:** Store and play sounds, with data stored in Firestore and audio files in Firebase Storage.
- **Upload Media files:**We first upload our media files to Firebase Storage, then store the corresponding media URLs in Firestore, which are later retrieved and utilized within our application.
- **Currently, our Figma design does not include play or pause buttons. As a temporary solution, when an item in the list is tapped, the corresponding audio stored in our Firestore database starts playing in the background. However, the audio stops automatically after completing playback.

## Installation
1. **Prerequisites:**
   - **Flutter SDK:** Install Flutter
   - **Firebase Account:** Create Firebase Project


2. **Clone the repository:**
  
   - **git clone https://github.com/TRS-MaryamRahim786/Breathin-App.git
   - ** cd Breathin-App
   

3.**Creating APK:**
- ** Run the command : "flutter build apk --split-per-abi"
>>>>>>> master
