<p align="center">
  <picture>
    <img src="./assets/images/repo_image.png">
  </picture>
  <h4 align="center">An interpretation of the Imgur application using Flutter!</h4>
</p>

---

### Design

For this project I started out in [Figma](https://www.figma.com/design/GV0LV0pmyXxfweXvBi6VYR/Rugmi-app?node-id=0-1&t=NIKVUKn1YVBNpHcI-1) designing how I wanted the application to look and to prototype navigation in the app. I always find the prototyping stage a lot of fun and it can be very easy to get lost in the process, but the end result is invaluable and provides an amazing kick off point for a project.

---

### Implementation

<div style="padding: 1px"></div>

#### Navigation

For navigation I chose to use the [go_router](<[https](https://pub.dev/packages/go_router)://pub.dev/packages/flutter_bloc>) package. The stock Material Navigation leaves something to be desired and having full visibility of your app routes in one place allows for easier scalability and understanding of an applications structure.

<div style="padding: 3px"></div>

#### State Management

For state management I chose to use the [Flutter_Bloc](https://pub.dev/packages/flutter_bloc) package.This was

---

### How to Run

<div style="padding: 1px"></div>

First of all you'll need to create and populate a .env file at the root of the project. You can use the .env.sample file as a guide for this. If you have an Imgur application registered already you can just populate the fields, if you not then you'll need to follow Imgur's API guide [here](https://apidocs.imgur.com/).

Once you have this then just go ahead and choose which environment you want to run against and you're in! You can also launch from the terminal using:

```#bash
flutter run
```

---

### Improvements

<div style="padding: 1px"></div>

There are many improvements to be made to this small application, not limited to:

<div style="padding: 3px"></div>

#### Visusal Improvements

I'm happy with the UI and style guide I created for the app but some animation would give it some flare and extra polish. I'd add a pull down to refresh function for the main page with a nice Lottie / Rive animation like the Imgur app.

<div style="padding: 3px"></div>

#### Infrastructural Improvements

Right now the application just uses local storage through Hive Box. It would be nice to hook this up to third party OAuth solutions for account creation. This would mean creating a Sign In/Out and Account/Profile flows but would unlock persistent storage of user data improving the experience dramatically.

<div style="padding: 3px"></div>

#### More Tests

I chose to focus on functional testing mostly around the state management functionality in the application. This is mainly because this business logic is used more frequently and is more likely to break when extending the application. However, testing of the API responses is also a good idea as there may be unknown changes to the API response that we don't expect and causes the application to crash.
