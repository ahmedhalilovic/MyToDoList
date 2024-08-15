# MyToDoList App

**MyToDoList** is a simple to-do list application built using UIKit and Realm. This app allows users to create, view, and delete to-do items, each associated with a specific date.

## Features

- **Create To-Do Items:** Add new to-do items with a specific date.
- **View To-Do Items:** See a list of all your to-do items.
- **Delete To-Do Items:** Remove items from the list when they're no longer needed.
- **Persistent Data:** All to-do items are stored locally using Realm for persistence.

## Getting Started

### Prerequisites

- Xcode 12.0 or later
- iOS 13.0 or later
- [Realm Swift](https://realm.io/docs/swift/latest/) installed via CocoaPods or Swift Package Manager

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/ahmedhalilovic/MyToDoList.git
   ```

2. Navigate to the project directory:

   ```bash
   cd MyToDoList
   ```

3. Install Realm if not already installed:

   ```bash
   pod install
   ```

4. Open the `.xcworkspace` file in Xcode:

   ```bash
   open MyToDoList.xcworkspace
   ```

### Usage

1. **Run the App:** Build and run the app on a simulator or an actual iOS device.
2. **Add a To-Do Item:** Tap the "Add" button, enter the to-do item text, select a date, and press "Save".
3. **View To-Do Items:** All saved to-do items will be displayed in a list.
4. **Delete a To-Do Item:** Tap on a to-do item to view its details, then tap the trash icon to delete it.

## Code Overview

### `ToDoListItem` Class

The `ToDoListItem` class represents the model for each to-do item, with properties for the item text and date.

```swift
class ToDoListItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}
```

### `ViewController`

This is the main view controller, displaying the list of to-do items. It handles the addition of new items and the display of existing items using a `UITableView`.

### `EntryViewController`

This view controller handles the creation of new to-do items. It uses a text field for the item description and a date picker for the date.

### `ScreenViewController`

This view controller is used to display the details of a selected to-do item. It also provides the functionality to delete the item.

## Acknowledgements

- [Realm Swift Documentation](https://realm.io/docs/swift/latest/)
