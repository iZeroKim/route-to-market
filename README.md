# Visit Tracker App 🚀

A mobile Flutter application that helps sales agents track visits to customers as part of a Route-to-Market Sales Force Automation system.

## 📸 Screenshots


---

## 🧠 Overview

This app allows field agents to:
- View a list of customer visits
- See detailed visit information
- Track activity counts per visit
- View summary statistics
- Work offline and sync data when back online - to be completed

The backend is powered by a RESTful Supabase service, and the app uses **Clean Architecture** principles for scalability and maintainability.

---

## 🏗️ Key Architectural Choices

| Layer            | Framework / Tool          | Reason |
|------------------|---------------------------|--------|
| State Management | `flutter_bloc`            | Well-supported, testable, and fits well with Clean Architecture |
| Networking       | `http` + `Supabase REST`  | Lightweight and direct REST API integration |
| Architecture     | Clean Architecture         | Clear separation of concerns: UI, Domain, Data |
| Persistence      | `drift` | Efficient local storage for offline support |
| Testing          | `flutter_test` + mocks     | Ensures reliability and correctness |

---

## ⚙️ Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/your-username/visit-tracker-app.git
cd field_flow
