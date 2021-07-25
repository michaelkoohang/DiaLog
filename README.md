# DiaLog

## About

DiaLog is a type 2 diabetes tracking app focused on ensuring privacy through on-device storage and processing. Something I was very alarmed by with many diabetes tracking apps (and health apps in general) is that they store your data in the cloud without being very transparent about it. I wanted to create an experience that was entirely on device so that people would feel safe knowing that their personal health data never left their phone. The app was part of my senior capstone project during undergrad and was done in partnership with [Mercer University's School of Medicine](https://medicine.mercer.edu/).

## How it works

DiaLog allows users with type 2 diabetes to log a few pieces of information that are important to them:

1. Blood Sugar
2. A1C Levels
3. Medications
4. Foot checks

The log screen allows users to easily select which item they want to log and switch between them. When the data is logged, it's saved on device using Core Data. If the user makes a mistake while logging something, an error message is displayed to provide detailed feedback on what they did incorrectly.

Whenever users visit the app, they can see their most recent logs at a glance on the home screen. They can also view graphs and lists of all the data they log over time, making it very easy to keep track of their data, analyze trends, and share it with their doctor, all while maintaining their right to privacy.

| Home | Log | Error
| :---: | :---: | :---: |
| ![DiaLog Home Screenshot][home-screenshot] | ![DiaLog Log Screenshot][log-screenshot] | ![DiaLog Error Screenshot][error-screenshot] |

## Built with

* [Swift](https://swift.org)
* [UIKit](https://developer.apple.com/documentation/uikit)
* [Core Data](https://developer.apple.com/documentation/coredata)
* [Lottie](https://airbnb.design/lottie/)
* [ScrollableGraphView](https://github.com/yhmnin/Scrollable-GraphView)

[home-screenshot]: Images/dialog-ss-1.png
[log-screenshot]: Images/dialog-ss-2.png
[error-screenshot]: Images/dialog-ss-3.png
