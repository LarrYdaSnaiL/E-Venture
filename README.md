# E-Venture

E-Venture adalah aplikasi mobile untuk mempermudah pengelolaan acara kampus, mulai dari pembuatan
event, pendaftaran online, hingga absensi berbasis QR Code yang cepat dan akurat. Aplikasi ini juga
mengolah data peserta secara otomatis sehingga panitia dapat membuat laporan dengan lebih efisien,
sementara peserta dapat mengikuti seluruh proses langsung melalui smartphone.

## Overview

E-Venture didesain untuk mendukung dua peran pengguna dalam manajemen event:

* **Panitia**: Mencari event yang ada di lingkungan kampus,
* **Panitia**: Membuat dan memanajemen event yang akan dilaksanakan.

## Project Structure

```agsl
lib/
├── api/                        # Firebase Services
├── models/                     # Data model and DTOs
├── navigation/                 # Routes
├── providers/                  # Firebase Providers
├── screens/                    # Screens
│   ├── auth/                   # Authentication Screens
│   ├── dashboard/              # Dashboard Screens
│   ├── event/                  # Event Screens
│   ├── home/                   # Home Screens
│   ├── profile/                # Profile Screens
│   └── qr/                     # QR and Scanner Screens
├── services/                   # QR and CSV Services
├── utils/                      # Utilities and Helpers
└── widgets/                    # Reuseable Components
```

## Key Features

### Pengguna

* Mencari event yang ingin diikuti
* Mendaftarkan event yang ingin diikuti
* Menampilkan QR konfirmasi kehadiran

### Panitia

* Membuat event yang sedang dilaksanakan
* Melakukan monitoring terhadap event yang sudah dibuat
* Mengekspor laporan dari event yang sudah dibuat

## Tech Stack

* **Language**: Dart
* **UI Framework**: Flutter
* **Architecture**: Clean Architecture + MVVM

## Team Members

Proyek ini dikerjakan oleh tim beranggotakan 3 orang, yaitu:

* Rafi Fauzan Tsany Lubis (231401120)
* Daffa Prawira Akbar (231401093)
* Farhan Ar Rahman (231401081)