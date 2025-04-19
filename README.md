# kaginewsproject
Demo project for Kagi Flutter app developer position.

## Setup instructions
#### Make sure you have flutter installed.
1. #### Clone the repository
```bash
git clone https://github.com/CosmicRaptor/kaginewsproject.git
cd kite-news-app
```
2. #### Install dependencies
```bash
flutter pub get
```
3. #### Follow [Google's](https://firebase.google.com/docs/flutter/setup) instructions to setup firebase for the project
4. #### Build/run the app
```bash
flutter build apk
flutter run
```


## Problem Statement

The project is to build a simple news aggregator application using Flutter. The core requirements are:

- Develop a Flutter application that displays news as aggregated by Kagi's Kite news app.
- Specifically, implement category-based news feedsa using the predefined categories at https://kite.kagi.com/kite.json
- Each categories articles and topics can then be found at https://kite.kagi.com/<category>.json
- Display news articles in a list view with appropriate metadata (title, source, date, etc.)
- Allow users to tap on articles to view a detailed summary


This project tests your ability not only to develop Flutter applications, but to deal with ambiguity and open-endedness, which is essential in a small, fast-moving company like Kagi. The goal of the demo project is not to copy the web app, but to demonstrate your ability of using Flutter to achieve native experiences beyond what a web app could do. Achieving native look&feel, using interactions/animations/haptics that would make the app more joyful to use than a PWA version. This is the whole reason one would use Flutter vs a webview.

## Inspiration
This project is modeled on Kite, Kagi's news application. It should be fast and intuitive, giving users a quick overview of what's going on in the world. The UX should be roughly similar, but feel free to make any tweaks that you think make sense.

## Technical Requirements
- Use Flutter and Dart for implementation
- Create a clean, responsive UI that works on both iOS and Android
- Handle network requests and errors gracefully
- Follow sensible coding conventions and patterns
- Include appropriate tests (widget tests, unit tests)

Out of scope
- Any sort of user settings/authentication/etc
- Filtering or customization of news articles
- Support for video news
- Adding additional sources outside of Kite

Some Guidelines
- Do the project in a way that shows off your skills as a developer
- Deliverable is the completed project, in a github repo, deployed somewhere or a TestFlight / TestApp link to test it on mobile
- Review and address flutter analyze and linter
- Create a README file with setup instructions
- Make sure to include screenshots or videos of the completed application

# Progress milestones
### 09 April 2025
- Basic MVVM architecture laid out, models created
- Data fetching completed
- Basic Home screen UI laid out
- Shimmer loading, haptic feedback implemented for the home screen

https://github.com/user-attachments/assets/392669d8-6352-445a-ba53-f849105a59c4

### 12 April 2025
- News screen UI mostly completed
- Lazy loading implemented for all tabs
- Automatic dark and light themes implemented
- Following sections are implemented:
![image](https://github.com/user-attachments/assets/6c2f3fa8-25d2-44f1-85f4-714e00f4b2c9)


https://github.com/user-attachments/assets/7fd05ae1-315b-4e95-8974-840aed73cccf

### 13 April 2025
- Onboarding screen added (Particle effect made from scratch in Canvas)
- Page transitions added
- Notification support added
- App is entering the polish stage, most features delivered.

https://github.com/user-attachments/assets/01362cd9-9917-4ef0-9bb0-c00d2f5cea8a

### 17 April 2025
- Settings screen added
- On this day JSON model mapped and screen designed.
- Page transition, loading animations polished
- Started refractoring the codebase to make it testable
- Started adding unit tests, widget tests coming soon.
- Started work on caching pages.


https://github.com/user-attachments/assets/1abbf9a8-1bde-4b98-b65e-63018d0d22a4

### 18 April 2025
- Implemented caching for all pages(Users need to load a category at least once for all pages on it to be cached)
- Uses etag and last-modified headers for determining if there's new content
- greatly improves the responsiveness of the app
- Video recorded with the internet connection turned off for the second half.



https://github.com/user-attachments/assets/e309e778-1b70-4c0f-8c41-374d3507af9b





### What's left:
- Writing unit tests
- Some documentation

### USPs planned:
- Push notifications whenever new articles come out - Implemented on the client side using firebase.
- WearOS integration







