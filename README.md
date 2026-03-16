# DailyDose (Early Prototype)

DailyDose is a SwiftUI medication reminder app prototype.

## Team Contributions

Member 01
Bramjot Singh
Student ID: 101511990

- UI design and layout
- Today Schedule screen
- DoseRowView and HistoryRowView components

Member 02
Ripon Sutradhar Rimon
Student ID: 101517912

- Data models (Medication, DoseLog)
- AppStore state management
- Data persistence

Member 03
Al Shahriar Fahmid
Student ID: 101515027

- Add Medication feature
- Medication history functionality
- Connecting UI with data store

## Functional screens implemented

- Splash screen with navigation into the app
- Today’s Schedule screen powered by real `Medication` model data
- Add Medication screen that saves real medication entries
- Medication History screen that shows real `DoseLog` entries after a medication is marked as taken

## Early prototype requirement coverage

This version satisfies the early prototype milestone by making roughly 30% of the app functional:

- real app models are used instead of mock text
- users can add medications
- added medications appear in Today’s Schedule
- users can mark a medication as taken
- taken medications appear in Medication History
- medication and history data persist locally using `UserDefaults`

## How to Run

1. Open `DailyDose.xcodeproj` in Xcode
2. Select an iPhone simulator
3. Run the project with `⌘R`

## Notes

- Data is stored locally on device using `UserDefaults`
- The prototype focuses on the core medication workflow for the milestone
