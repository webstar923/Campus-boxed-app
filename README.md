
# 📦 Boxed Campus Storage – Mobile App

A cross-platform Flutter mobile application for university students and families to reserve, manage, and track their campus storage through Boxed Campus Storage.

This app simplifies student storage by offering reservation, QR-code-based item scanning, real-time status tracking, chat support, and secure payment processing via Stripe.

---

## 🚀 Features

- 📱 **Cross-platform UI** built with Flutter
- 🔐 **User authentication** (students and parents)
- 🗓️ **Storage reservation system**
- 📦 **Item inventory tracking** with QR code scanning
- 💬 **In-app chat support** with fallback to live agent
- 💳 **Stripe payment integration**
- ☁️ **Secure image & document storage via AWS S3**
- 📍 **Real-time pickup & delivery status updates**
- 🔔 **Push notifications** for status changes and reminders

---

## 🛠️ Tech Stack

| Layer      | Technology     |
|------------|----------------|
| Frontend   | Flutter         |
| Backend    | Laravel (PHP)   |
| Payments   | Stripe API      |
| Storage    | AWS S3          |
| Chat       | In-app chatbox with escalation |

---

## 🧰 Installation

### 🔧 Prerequisites

- Flutter 3.x
- Dart SDK
- Node.js & npm (for Stripe CLI if needed)
- Laravel backend configured and running
- AWS S3 credentials setup

### 🖥️ Clone the repo

```bash
git clone https://github.com/webstar923/Campus-boxed-app.git
cd Campus-boxed-app
```

### 📦 Install dependencies

```bash
flutter pub get
```

### ▶️ Run the app

```bash
flutter run
```

Make sure you have an emulator running or a device connected.

---

## 🌐 Environment Configuration

Create a `.env` file in the root directory with the following structure:

```env
API_BASE_URL=https://boxedcampusstorage.com/api
AWS_S3_BUCKET=boxedcampusstorage
STRIPE_PUBLIC_KEY=
```

Backend Laravel `.env` must also be configured for Stripe and AWS S3 credentials.

---

## 📝 Usage Flow

1. **Guest Browsing** – Learn about Boxed and services offered.
2. **Reservation** – Choose school, input details, select payment method.
3. **Account Creation** – Seamlessly link student & parent accounts.
4. **Scan Items** – Label and scan storage items using QR code.
5. **Real-Time Updates** – Track pickup, storage, and drop-off status.
6. **Chat Support** – Ask questions or resolve issues in-app.
7. **Review & Referral** – Complete service and refer friends.

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss.

---

## 📄 License

MIT © 2024 Boxed Campus Storage

---

## 📬 Contact

Website: [https://boxedcampusstorage.com/](https://boxedcampusstorage.com/)

---

## 🔄 Real-Time Pickup & Delivery Status Updates

To power real-time status updates for item pickup and delivery, this app can be integrated with the following tech stacks:

### 🔧 Backend Options
- **Laravel + Pusher**: Leverage Laravel Echo and broadcasting to push real-time updates to users.
- **Firebase Firestore + Firebase Cloud Messaging**: For real-time syncing and push notifications, especially with Flutter.
- **Redis Pub/Sub + WebSocket Server**: Ideal for high performance and scalability in custom solutions.
- **AWS AppSync + GraphQL Subscriptions**: Seamless integration for GraphQL-based real-time functionality.
- **Supabase**: Offers PostgreSQL and real-time subscriptions out of the box.

### 📱 Flutter Frontend Integration
- **flutter_pusher_client / pusher_channels_flutter**: Compatible with Laravel + Pusher backend.
- **firebase_messaging**: For push notifications via Firebase.
- **graphql_flutter**: For integrating GraphQL subscriptions from services like AppSync.
- **Flutter WebSocket**: For custom WebSocket connections.

These technologies ensure customers receive real-time updates about their inventory pickup, delivery stages, and confirmation status—all within the app interface.


---

## 💬 Real-Time Chat System

The app includes a built-in chat function to support communication between users and Boxed Campus Storage staff. Below are recommended stacks for implementing real-time chat:

### 🔧 Backend Options
- **Laravel + Pusher/Ably**: Use Laravel events and broadcasting with services like Pusher or Ably to enable instant messaging.
- **Firebase Realtime Database / Firestore**: Easily integrate with Flutter for real-time chat data syncing and offline support.
- **Socket.IO + Node.js**: For building a fully custom WebSocket-based chat service.
- **Supabase**: Real-time capabilities via PostgreSQL and built-in subscriptions.

### 📱 Flutter Frontend Integration
- **flutter_pusher_client / pusher_channels_flutter**: Connects Flutter to Laravel + Pusher or Ably.
- **firebase_database / cloud_firestore + firebase_auth**: Enables chat with minimal setup and good scalability.
- **Flutter WebSocket or socket_io_client**: For lower-level control with Socket.IO-based backends.
- **stream_chat_flutter**: A commercial and fully-featured chat SDK with moderation, attachments, and rich media support.

These options enable features such as:
- Real-time text messaging
- Typing indicators
- Read receipts
- Image/file sharing
- Push notifications

