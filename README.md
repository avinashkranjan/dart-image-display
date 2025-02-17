# Dart Image Link

A Flutter web application that loads an image from a URL, displays it using an HTML `<iframe>`, and provides fullscreen toggling and a context menu.

## Features

- **Dynamic Image Loading:** Enter a URL to load an image via an HTML `<iframe>` element.
- **Fullscreen Toggle:** Double-click on the image or use the context menu to enter or exit fullscreen mode.
- **Context Menu:** A floating "Plus" button reveals a context menu with fullscreen options. The background dims when the menu is open, and clicking outside dismisses it.
- **Cross-Browser Compatibility:** Special handling for different browsers (e.g., Firefox) when registering the view factory.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/) installed on your machine.
- Flutter web enabled. You can check this by running:
  ```bash
  flutter devices
  ```
  Ensure that `Chrome` or another web browser is listed as one of the devices.

### Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your_username/dart-image-link.git
   cd dart-image-link
   ```

2. **Get the Dependencies:**
   ```bash
   flutter pub get
   ```

### Running the Application

Run the project in your browser by executing:

```bash
flutter run -d chrome
```

Your default browser should launch the app, allowing you to interact with it.

## Usage

1. **Load an Image:**
   - Enter the image URL into the text field.
   - Click the arrow button to load the image into an HTML `<iframe>` element.

2. **Toggle Fullscreen:**
   - Double-click on the displayed image to toggle fullscreen mode.
   - Alternatively, click the floating "Plus" button to open the context menu, then select "Enter Fullscreen" or "Exit Fullscreen".

3. **Dismiss the Context Menu:**
   - Click outside the context menu area to close it.

## Project Structure

- **main.dart**  
  The main file containing the Flutter application logic:
  - Handles URL input and image loading using an HTML `<iframe>`.
  - Implements fullscreen toggling using JavaScript interop.
  - Manages a context menu for additional fullscreen controls.
