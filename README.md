<p align="center">
  <picture>
    <img src="./assets/images/repo_image.png">
  </picture>
  <h4 align="center">An interpretation of the Imgur application using Flutter!</h4>
</p>

---

## Table of Contents

- [Design](#design)
- [Implementation](#implementation)
- [How to Run](#howto)
- [Future Work and Improvements](#futurework)

### Design <a name="design"></a>

For this project I started out in [Figma](https://www.figma.com/design/GV0LV0pmyXxfweXvBi6VYR/Rugmi-app?node-id=0-1&t=NIKVUKn1YVBNpHcI-1) designing how I wanted the application to look and to prototype navigation in the app. I always find the prototyping stage a lot of fun and it can be very easy to get lost in the process, but the end result is invaluable and provides an amazing kick off point for a project.

<p align="center">
  <picture>
    <img src="https://github.com/user-attachments/assets/89cadb21-6ee2-4c2f-8bca-ec4c2f117f79">
  </picture>
</p>

<hr style="border-top: 1px solid #bbb;" />

### Implementation <a name="implementation"></a>

<div style="padding: 1px"></div>

#### Navigation

For navigation I chose to use the [go_router](<[https](https://pub.dev/packages/go_router)://pub.dev/packages/flutter_bloc>) package. The stock Material Navigation leaves something to be desired and having full visibility of your app routes in one place with declaritive routing. Nested navigation support also allows for easier scalability and understanding of an applications structure at a glance, and plays well with Bloc.

<div style="padding: 3px"></div>

<hr style="border-top: 1px solid #bbb;" />

#### State Management

For state management I chose to use the [Flutter_Bloc](https://pub.dev/packages/flutter_bloc) package. I am used to using MobX for state management in Flutter and for this project I wanted to challenge myself to implement a different state management solution. Bloc presents improvements over MobX like forcing me to think about writing structurally because I don't necessarily have the benefit of MobX's flexibility. The end result is a completely clean UI layer, letting me pull all of my business logic away from my views and made desgining tests much easier!

<div style="padding: 3px"></div>

---

#### Storage

I wanted to keep the storage simple in this application as I'm not targetting a production release. To do this I opted for [Hive](https://github.com/isar/hive) package. I chose to use this as it's a NoSQL storge solution which made storing my JSON models simpler and the implementation / documentation for Hive was great - assuming you don't attempt to access it through pub.dev.

<div style="padding: 3px"></div>

---

#### Testing

As is always the case, testing when a database is involved was not fun. But luckily there's has a great package for this: [hive_test](<[https](https://pub.dev/packages/hive_test)://github.com/isar/hive>). hive_test simplifies testing of my Hive methods by creating a new Hive instance in a temporary directory which is then torn down after testing is completed. This is ideal because it means we don't have to attempt to mock each method call to Hive and instead I can just use my regular hive methods against the new Hive instance.

<hr style="border-top: 1px solid #bbb;" />

### How to Run <a name="howto"></a>

<div style="padding: 1px"></div>

#### Installation

1. Clone the repository:

```bash
 git clone https://github.com/davidlonsdale92/rugmi.git
```

2. Install dependencies:

```bash
 flutter pub get
 cd ios
 pod install
```

#### Setup

First of all you'll need to create and populate a .env file at the root of the project. You can use the .env.sample file as a guide for this. If you have an Imgur application registered already you can just populate the fields, if you not then you'll need to follow Imgur's API guide [here](https://apidocs.imgur.com/).

#### Running

Once you have this then just go ahead and choose which environment you want to run against and you're in! You can also launch from the terminal using:

```sh
# Development
$ flutter run --flavor development --target lib/entrypoints/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/entrypoints/main_staging.dart

# Production
$ flutter run --flavor production --target lib/entrypoints/main_production.dart
```

<hr style="border-top: 1px solid #bbb;" />

### Future Work and Improvements <a name="futurework"></a>

<div style="padding: 1px"></div>

There are many improvements to be made to this small application, not limited to:

<div style="padding: 3px"></div>

#### Visusal Improvements

I'm happy with the UI and style guide I created for the app but some animations would give it some flare and extra polish. I'd like to add a pull down to refresh function for the main page with a nice Lottie / Rive animation like you see in the Imgur app. I purposely chose to keep page transitions to a minimum but it might be worth exploring some more obscure and fun transitions to match the playful theme set by the brand images in the app.

<div style="padding: 3px"></div>

---

#### Infrastructural Improvements

Right now the application just uses local storage through Hive Box. It would be nice to hook this up to third party OAuth solutions for account creation like the Imgur application does (something like Firebase). This would mean creating a Sign In/Out and Account/Profile flows but would unlock persistent storage of user data improving the experience dramatically.

<div style="padding: 3px"></div>

---

#### API Improvements

Right now this is just a basic implementation of what could be possible with the Imgur API. It would be great to enable filtering / sorting for the gallery, upload new images directly from the app and replicate the comments section beneath images in the detailed screen.

<div style="padding: 3px"></div>

---

#### More Tests

I chose to focus on functional testing mostly around the state management functionality in the application. This is mainly because this business logic is used more frequently and is more likely to break when extending the application. However, testing of the API responses is also a good idea as there may be unknown changes to the API response that we don't expect and causes the application to crash. It would have been better to have created some models for responses I expect back from the API and use these to mock responses for testing purposes.

<hr style="border-top: 1px solid #bbb;" />

<p align="center">
  <picture>
    <img src="./assets/images/error.png">
  </picture>
</p>
