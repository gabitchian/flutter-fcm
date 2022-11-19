<p align="center">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/gabitchian/flutter-fcm?color=%2304D361&style=for-the-badge">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/gabitchian/flutter-fcm?style=for-the-badge">

  <a href="https://github.com/gabitchian/flutter-fcm/commits/main">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/gabitchian/flutter-fcm?style=for-the-badge">
  </a>

   <img alt="License" src="https://img.shields.io/badge/license-MIT-brightgreen?style=for-the-badge">
   <a href="https://github.com/gabitchian/flutter-fcm/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/gabitchian/flutter-fcm?style=for-the-badge">
  </a>

  <a href="https://github.com/gabitchian">
    <img alt="Feito por Gabriela Tchian" src="https://img.shields.io/badge/feito%20por-Gabi%20Tchian-%231b9?style=for-the-badge">
  </a>

</p>
<!-- <h1 align="center" style="padding: 50px; background: #333333;">
    <img alt="flutter-fcm" title="#flutter-fcm" src="https://raw.githubusercontent.com/gabitchian/flutter-fcm/main/public/logo-full.svg" />
</h1> -->

<h2 align="center">
	🏁  Flutter with Firebase Cloud Messaging - In progress 🏁
</h2>
<p>
  ✅ [Android] Receive notifications while app in foreground or background
  <br />
  ✅ [Web] Receive notifications while app in foreground or background
  <br />
  ❌ [IOS] Receive notifications while app in foreground or background
  <br />
  <br />
  ❌ [Android] Send notifications
  <br />
  ✅ [Web] Send notifications
  <br />
  ❌ [IOS] Send notifications
  <br />
  <br />
  ❌ [Android] Save all notifications in a firebase database
  <br />
  ✅ [Web] Save all notifications in a firebase database before sending then
  <br />
  ❌ [IOS] Save all notifications in a firebase database
  <br /> 
</p>

<p align="center">
 <a href="#--about-the-project">About</a> •
 <a href="#--how-to-run-it">How to run it</a> •
 <a href="#--technologies">Technologies</a> •
 <a href="#--author">Author</a> •
 <a href="#--license">License</a>
</p>

## [](https://github.com/gabitchian/flutter-fcm#--about-the-project) 💻 About the project

This project was created so that I would learn how to receive and send notifications via firebase's cloud messaging service, while also saving it in firebase's database for notification management.

---

## [](https://github.com/gabitchian/flutter-fcm#--how-to-run-it) 🚀 How to run it

<br />

### 📝 Pre requirements

Before beginning, you'll need to have installed the following tools in your machine:
[Git](https://git-scm.com), [Chrome](https://www.google.com/intl/en-US/chrome/), [Flutter](https://docs.flutter.dev/get-started/install), [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/), an editor like [VSCode](https://code.visualstudio.com/).

You'll also need to have an account on Google's Firebase and a project created to configure the app.
<br />

#### ⚙️ Configuring App

Before starting, you'll need copy whats inside the file <code>/lib/firebase_options.dart</code> to another file, it'll be substitute after you run the following commands.
To configure the application, you'll need to run the following commands:

```bash

# Clone the repository
$ git clone git@github.com:gabitchian/flutter-fcm.git

# Access the repositories's folder
$ cd flutter-fcm

# Configure project for firebase
$ flutterfire configure
```

When running futterfire configure, you'll be prompted with a few questions:

- The project that will be connected to your App: you can create one while configuring or select one that was already created.
- What plataforms you want to configure support: you should select android, IOS and Web for this example
- It'll probably ask if you want to substitute your current configuration, mark yes
  <p>
    After configuring it, you'll need to get the current values on the <code>/lib/firebase_options.dart</code> file to their respective variable in the <code>.env-example</code> and the <code>web/firebase-messaging-sw-example.js</code>.
    Then you can rename <code>.env-example</code> to <code>.env</code> and <code>web/firebase-messaging-sw-example.js</code> to <code>web/firebase-messaging-sw.js</code> and also so paste back to <code>/lib/firebase_options.dart</code> what you saved in another temporary file.
  </p>

    <br />

#### 🧭 Running App

```bash

# Clone the repository
$ git clone git@github.com:gabitchian/flutter-fcm.git

# Access the repositories's folder
$ cd flutter-fcm

# Run on the opened emulator, such as Android or IOS device
$ flutter run

# Or
$ flutter run -d chrome
# Run on the browser, your app will open in a new tab automatically

```

---

## [](https://github.com/gabitchian/flutter-fcm#--technologies) 🛠 Technologies

The following tools were use on this project:

#### **App** (**[Flutter](https://docs.flutter.dev/get-started/install)** + **[FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)**)

#### **Utils**

- Editor: **[Visual Studio Code](https://code.visualstudio.com/)**
- README: **[BrunoSaibert's Template](https://github.com/BrunoSaibert/brunoquiz/blob/main/README.md)**
- Google Chrome: **[Chrome](https://www.google.com/intl/en-US/chrome/)**

---

## [](https://github.com/gabitchian/flutter-fcm#--author) 👩‍🚀 Author

 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/gabitchian" width="100px;" alt="Gabi Tchian"/>
 <br />
 <sub><b>Gabriela Tchian</b></sub></a>
 <br />

Made by Gabriela Tchian

👋 Contact me at:

[![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=for-the-badge&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/gabrielatchian/)](https://www.linkedin.com/in/gabrielatchian/)
[![Gmail Badge](https://img.shields.io/badge/-Gmail-c14438?style=for-the-badge&logo=Gmail&logoColor=white&link=mailto:gftchian0609@gmail.com)](mailto:gftchian0609@gmail.com)

---

## [](https://github.com/gabitchian/flutter-fcm#--license) 📝 License

This project is under the MIT license.
