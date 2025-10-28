# PROMPT+ - AI Image Generator

demo video:  https://github.com/user-attachments/assets/28ae56b8-696f-42df-b433-37f91099780e

## Features

- **Two Screens**: Prompt (input description) → Result (generation result)
- **State Management**: flutter_bloc
- **Navigation**: go_router
- **Modern UI**: Material Design 3 with gradients and smooth animations
- **Mock API**: Generation simulation with 2-3 sec delay and 50% error chance
- **Error Handling**: Beautiful error display with retry option

## Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart SDK 3.0.0 or higher
- iOS Simulator / Android Emulator or physical device

### Installation & Running

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pr
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   
   For iOS:
   ```bash
   flutter run -d ios
   ```
   
   For Android:
   ```bash
   flutter run -d android
   ```
   
   Or simply:
   ```bash
   flutter run
   ```
   
   Flutter will automatically detect available devices.

4. **Build for release (optional)**
   
   iOS:
   ```bash
   flutter build ios
   ```
   
   Android:
   ```bash
   flutter build apk
   ```

### Quick Test

Once the app is running:
1. Enter any text description (e.g., "Image")
2. Press "Generate" and watch the loading animation
3. On success, try "Try another" or "New prompt"
4. To see error handling, keep regenerating until you hit an error (~50% chance)

## Architecture

```
lib/
├── core/
│   ├── api/
│   │   └── mock_api.dart           # Mock API 
│   ├── router/
│   │   └── app_router.dart         # Navigation with go_router
│   └── theme/
│       └── app_theme.dart          # App UI theme
├── features/
│   ├── prompt/
│   │   ├── bloc/
│   │   │   ├── prompt_bloc.dart    # Bloc for Prompt screen
│   │   │   ├── prompt_event.dart
│   │   │   └── prompt_state.dart
│   │   └── presentation/
│   │       └── prompt_screen.dart  # Prompt input screen UI
│   └── result/
│       ├── bloc/
│       │   ├── result_bloc.dart    # Bloc for Result screen
│       │   ├── result_event.dart
│       │   └── result_state.dart
│       └── presentation/
│           └── result_screen.dart  # Result screen UI
└── main.dart                       # Entry point
```

## Usage

### Screen 1 - Prompt

1. Enter a description of the desired image in the text field
2. The "Generate" button becomes active only with non-empty input
3. Press "Generate" to navigate to the result screen

### Screen 2 - Result

1. The app automatically starts "generation" (loader for 2-3 sec)
2. On success, a placeholder image is displayed
3. Available buttons:
   - **"Try another"** - regenerate with the same prompt
   - **"New prompt"** - return to screen 1 (prompt text is preserved)
4. On error, an error message is shown with a **"Retry"** button

## Technical Details

### Dependencies

- `flutter_bloc: ^8.1.3` - State management
- `go_router: ^14.0.0` - Navigation
- `equatable: ^2.0.5` - Object comparison simplification

### Mock API

```dart
Future<String> generate(String prompt) async {
  await Future.delayed(Duration(seconds: 2 + Random().nextInt(2)));
  if (Random().nextBool()) {
    throw Exception('Generation failed');
  }
  return 'https://picsum.photos/seed/${prompt.hashCode}/600/600';
}
```

