# Directory

A small sample app using Mockapi.io 


## Topics

### Getting Started

To open the project please use the Directory.xcworkspace file. 

### Overview

The project is divided into 2 projects, the main App (Directory) covering the application framework and the Common local Swift package.

The Common Swift package contains 2 libraries:
- Common, containing useful extensions & property wrappers.
- DirectoryAPI, containing classes and views for interacting with the REST API
    
### Tests

The project contains a small number of Unit tests as an example. In a real-world project, we would include many more test covering both the happy & unhappy code paths.

## Notes

This example contains no 3rd party components for security. Ideally, I would recommend the following dependencies to aid in development.

- XCFormat, Xcode plugin to format code and fix simple syntax issues.

- [SwiftLint](https://github.com/realm/SwiftLint), A linting tool for Swift to enforce style and coding conventions. useful with teams of mixed experience to encourage best practises.

- [Swifter](https://github.com/httpswift/swifter), A small http server that can be used (with dependencies) to transparently redirect network requests to a local HTTP server where stubbed responses can be used to ensure consistent return data.<br/>This also comes in handy when testing error conditions such as Internal Server Error 500.

- [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing), This tool allows snapshot testing of multiple data types and objects e.g., Strings, JSON and Screenshots of Views.




- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
