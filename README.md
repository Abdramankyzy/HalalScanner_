# 🔍 HalalScanner

> An iOS app that uses computer vision and ML to scan food products and classify them as **Halal**, **Not Halal**, or **Doubtful** — in real time.

---

## 📱 About the Project

HalalScanner bridges the gap between religious dietary compliance and everyday grocery shopping. Users can scan product barcodes or point their camera at food items to instantly get halal status, nutritional info, and ingredient warnings — all personalized to their dietary profile.

Built with the **Dastarkhan AI** design language, the app is tailored for the Kazakhstani market with a local food database and Kazakh/Russian product recognition.

---

## ✨ Features

- 📷 **Real-time food scanning** via camera using Roboflow ML
- ✅ **Halal / Not Halal / Doubtful** classification with badge indicators
- ⚠️ **Ingredient warnings** — flags specific haram additives (e.g. gelatin, carmine)
- 📊 **Nutritional info** — calories, category per product
- 🕓 **Scan history** — view all previously scanned items
- ⭐ **Favorites** — save products for quick reference
- 👤 **User profile** — halal rate progress, scan stats
- 🔐 **Firebase Auth** — email/password sign in & registration
- 🛡️ **Admin panel** — view user ratings and feedback

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 5 |
| UI Framework | UIKit (programmatic) |
| Architecture | MVVM + Coordinator |
| ML / Vision | Roboflow (object detection) |
| Backend | Firebase Firestore + Firebase Auth |
| Dependency Manager | CocoaPods |

---

## 🚀 Getting Started

### Prerequisites
- Xcode 15+
- iOS 16+
- CocoaPods installed

### Installation

```bash
git clone https://github.com/YOUR_USERNAME/HalalScanner.git
cd HalalScanner
pod install
open HalalScanner.xcworkspace
```

> ⚠️ You will need to add your own `GoogleService-Info.plist` (Firebase) and configure your Roboflow API key in `Secrets.swift`.

---

## 📁 Project Structure

```
HalalScanner/
├── App/                  # AppDelegate, SceneDelegate, TabBarVC
├── Coordinator/          # AppCoordinator (navigation flow)
├── Models/               # Product catalog, AppUser
├── Modules/
│   ├── Auth/             # Login & Registration
│   ├── Scanner/          # Camera + ML detection
│   ├── ProductSheet/     # Product detail bottom sheet
│   ├── History/          # Scan history list
│   ├── Favorites/        # Saved products grid
│   ├── Profile/          # User stats & settings
│   └── Admin/            # Admin dashboard
├── CustomElements/       # HalalBadgeView, PaddingLabel
└── UIColor+HalalScanner/ # App color palette (Dastarkhan AI theme)
```

---

## 🎨 Design

The app follows the **Dastarkhan AI** visual identity:
- **Primary color:** Warm amber-orange `#E37D20`
- **Background:** Cream `#F5F4EB`
- **Typography:** SF Pro (system) with bold weight hierarchy
- **Theme:** Inspired by Kazakhstani culture and the traditional dastarkhan (feast table)

---

## 👥 Team

| Name | Student ID |
|---|---|
| Madina Abdiraman | 230103292 |
| Adel Kunuspekova | 230103231 |
| Aisulu Igimbayeva | 230103322 |
| Merey Ospanova | 230103055 |

---

*Suleyman Demirel University — Mobile Development Project, 2026*
