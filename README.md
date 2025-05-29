# Visit Tracker App 🚀

A mobile Flutter application that helps sales agents track visits to customers as part of a Route-to-Market Sales Force Automation system.

## 📸 Screenshots
#Visits list

<img src="[https://user-images.githubusercontent.com/.../image.png](https://github.com/user-attachments/assets/5212c846-554e-4541-8b17-91fc84ffd749)" alt="Screenshot" width="400">

# Visit details
![Screenshot_2025-05-29-23-45-37-09_aa60658cd3f19f08c50c717960654b5b](https://github.com/user-attachments/assets/2e311acb-fb7f-4119-ad1d-4555b61fce55)

---

## 🧠 Overview

This app allows field agents to:
- View a list of customer visits
- See detailed visit information
- Track activity counts per visit
- View summary statistics
- Work offline and sync data when back online - to be completed

Missing (Due to time constraints )
- Ability to add a new visit.
- Test cases.

The backend is powered by a RESTful Supabase service, and the app uses **Clean Architecture** principles for scalability and maintainability.

---

## 🏗️ Key Architectural Choices

| Layer            | Framework / Tool          | Reason |
|------------------|---------------------------|--------|
| State Management | `flutter_bloc`            | Well-supported, testable, and fits well with Clean Architecture |
| Networking       | `http` + `Supabase REST`  | Lightweight and direct REST API integration |
| Architecture     | Clean Architecture         | Clear separation of concerns: UI, Domain, Data |
| Persistence      | `drift`                    | Efficient local storage for offline support | - to be completed
| CI/CD            | `Github actions`           | Quick and easy to setup |
| Testing          | `flutter_test` + mocks     | Ensures reliability and correctness | - to be completed

---

## ⚙️ Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/iZeroKim/route-to-market.git
cd field_flow
flutter pub get
flutter run
