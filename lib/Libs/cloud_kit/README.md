<div align="center">
    <img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/logo.png" height="200">
</div>

# CloudKit

This Flutter plugin is a brige to use in your Flutter app CloudKit.

# 📝 Usage

Create a new CloudKit instance with your container id.

`CloudKit cloudKit = CloudKit("iCloud.dev.tutorialwork.cloudkitExample");`

Save a value with key

`cloudKit.save("key", "value")`

Access a value

`cloudKit.get("key")`

# 💻 Installation

1. Add the iCloud capability to your XCode project

<img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/step1.png" height="200">

2. Tick all the three options and create with the plus icon a new CloudKit container and select it.

<img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/step2.png" height="200">

3. Then add your first entry into the database with the [example app](https://github.com/Tutorialwork/cloud_kit/tree/main/example) in this repository.

<img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/step3.png" height="200">

4. Then open the [CloudKit Dashboard](https://icloud.developer.apple.com) and select your container and go to "Schema"

<img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/step4.png" height="200">

5. Click "Edit indexes". **Important**: To see this option you need to add your first database entry.

<img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/step5.png" height="200">

6. Click "Add Index".

<img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/step6.png" height="200">

7. 🎉 Now click save. You're done and can start now using my plugin. 🎉

<img src="https://raw.githubusercontent.com/Tutorialwork/cloud_kit/main/images/step7.png" height="200">
