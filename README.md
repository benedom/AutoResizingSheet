# AutoResizingSheet
[![Build](https://github.com/benedom/AutoResizingSheet/actions/workflows/build-swift.yml/badge.svg?branch=master)](https://github.com/benedom/AutoResizingSheet/actions/workflows/build-swift.yml)
![Static Badge](https://img.shields.io/badge/Platform%20-%20iOS%20-%20light_green)
![Static Badge](https://img.shields.io/badge/iOS%20-%20%3E%2016.0%20-%20light_green)
![Static Badge](https://img.shields.io/badge/Swift%20-%20%3E%205.9%20-%20orange)
<a href="https://github.com/benedom/AutoResizingSheet/blob/master/LICENSE.md">
  <img src="https://img.shields.io/badge/License%20-%20MIT%20-%20blue" alt="License - MIT">
</a>

<p align="center">
    <img src="https://github.com/benedom/AutoResizingSheet/blob/master/Assets/dynamicSheet.gif" style="margin: auto; width: 250px"/>
</p>

<p align="center">
    <img src="https://github.com/benedom/AutoResizingSheet/blob/master/Assets/staticSheet.gif" style="margin: auto; width: 250px"/>
</p>

<p align="center">
    <img src="https://github.com/benedom/AutoResizingSheet/blob/master/Assets/asyncSheet.gif" style="margin: auto; width: 250px"/>
</p>

## 🔭 Overview
AutoResizingSheet is a SwiftPackage which allows to display sheets which will automatically resize itself with an animation when the content height changes. This is useful when the sheet fetches data, where it is not known how large the content will be.

It also works for static sheet content. The height of the sheet is calculated so it matches the content perfectly.

AutoResizingSheet also solves the issue of height detents for different devices. The content in the sheet will automatically be displayed, so that it fits the current device perfectly - no more blank spaces.

AutoResizingSheet can be displayed using a SwiftUI ViewModifier or presented as a UIKit ViewController. See [Usage](#🛠️-usage) for details.

## 📕 Contents

- [Requirements](#-requirements)
- [Installation](#-installation)
- [Demo App](#📱-demo-app)
- [Usage](#-usage)
- [Contributors](#-contributors)
- [Author](#-author)
- [License](#-license)

## 🧳 Requirements

- iOS 16.0 or later
- Xcode 15.0 or later
- Swift 5.9 or later


## 💻 Installation
There are two ways to use AutoResizingSheet in your project:
- using Swift Package Manager
- manual install (embed Xcode Project)

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `AutoResizingSheet` into your Xcode project using Xcode 15.0 or later, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/benedom/AutoResizingSheet, :branch="master"
```

### Manually

If you prefer not to use any of dependency managers, you can integrate `AutoResizingSheet` into your project manually. Put `Sources/AutoResizingSheet` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## 📱 Demo App

To get a feeling how `AutoResizingSheet` works and in what scenarios it can be used, you can run the demo app. The demo app provides multiple sheet implementations to test and also a fully configurable `AutoResizingSheetConfiguration`.

## 🛠️ Usage

### SwiftUI
This example shows how to display `AutoResizingSheet` inside a SwiftUI View:
```swift
import SwiftUI
import UIKit
import AutoResizingSheet

struct ExampleView: View {
    let presentingViewController: UIViewController
    @State private var showSheet: Bool = false

    var body: some View {
        VStack {
             Button("Show sheet") {
                showSheet.toggle()
             }
        }
        .autoResizingSheet(
            isPresented: $showSheet,
            presentingViewController: presentingViewController
        ) {
            // Your sheet content View
            SheetContentView()
        }
    }
}
```

```
:bangbang: NOTE: The resizing will not work properly if your view is wrapped inside a ScrollView. Use scrollable of AutoResizingSheetConfiguration instead, to make the content scrollable. :bangbang:
```

The viewModifier takes multiple parameters:

| Paramter      | Description |
| ----------- | ----------- |
| `isPresented` | `Binding<Bool>`: Binding to control the displaying of the sheet. |
| `onDismiss` | `(() -> Void)?`: A closure that is executed when the sheet is dismissed. Defaults to `nil`. |
| `configuration` | `AutoResizingSheetConfiguration`: The custom configuration to use. If not set, uses default configuration. |
| `presentingViewController` | `UIViewController?`: The sheet is presented as a `UIHostingController` so it needs a `UIViewController` that presents it. If you do not supply one, the rootViewController is searched, which may fail. |
| `@ViewBuilder content` | `@escaping () -> Content`: The content of the sheet as a SwiftUI View. |

<br></br>
You can also configure `AutoResizingSheet` by passing a `AutoResizingSheetConfiguration`. A configuration has the following properties:

| Property      | Description |
| ----------- | ----------- |
| `scrollable` | `Bool  `: Should the content be wrapped inside a scroll view. Defaults to `true`. |
| `showGrabber` | `Bool`: If the grabber should be shown. Defaults to `true`. |
| `initialDetent` | `UISheetPresentationController.Detent`: Initial detent of the sheet before resizing. Defaults to `medium`. |
| `extendableToFullSize` | `Bool`: If the sheet is extendable  to full size using the grabber. Defaults to `true`, will be `false` if `showGrabber` is `false`. |

Create a configuration like this:
```swift
let configuration = AutoResizingSheetConfiguration(
    scrollable = true,
    showGrabber: true,
    initialDetent: .medium(),
    extendableToFullSize: true
)
```

and use it like this:

```swift
.autoResizingSheet(
    isPresented: $showSheet,
    configuration: configuration,
    presentingViewController: presentingViewController
    ) {
        // Your sheet content View
        SheetContentView()
    }
```

### UIKit
This example shows how to display `AutoResizingSheet` using a `UIViewController` in UIKit:

```swift
func showSheet() {
    // Create the view for the sheet content
    let sheetContentView = YourSwiftUISheetView()
    // Present the sheet
    yourViewController.presentViewAsAutoResizingSheet(content: sheetContentView)
}
```

The function takes multiple parameters:

| Paramter      | Description |
| ----------- | ----------- |
| `content` | `@escaping () -> Content`: The content of the sheet as a SwiftUI View. |
| `configuration` | `AutoResizingSheetConfiguration`: The custom configuration to use. If not set, uses default configuration. |
| `onDismiss` | `(() -> Void)?`: A closure that is executed when the sheet is dismissed. Defaults to `nil`. |

Just like using the SwiftUI ViewModifier, you can pass a `AutoResizingSheetConfiguration`.

## 👨‍💻 Contributors

All issue reports, feature requests, pull requests and GitHub stars are welcomed and much appreciated.

## ✍️ Author

Benedikt Betz & CHECK24

## 📃 License

`AutoResizingSheet` is available under the MIT license. See the [LICENSE](https://github.com/benedom/SwiftyCrop/blob/master/LICENSE.md) file for more info.
