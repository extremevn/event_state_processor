# [0.0.1] - 2020/07/07
## 1st version
Features:
- Support flutter_bloc: ^4.0.0
- Provide short, clear, separated base classes for both UI (screen) and logic (processor)

# [0.0.2] - 2021/04/16
Updates:
- Fixed static analysis issues
- Updated example dependency point to pub.dev

# [0.1.0] - 2021/07/20
Updates:
- Updated flutter_bloc version to 7.0.1 for support Null Safety
- Updated example code

# [1.0.0] - 2022/01/19
Updates:
- Changed 'CoreScreen' Widget to 'StatefulWidget' for support: 
  - Screen init, dispose callback
  - TickerProvider for animation
- Added shortcut, util functions: 
  - BuildContext quick access
  - Processor and currentState quick access
- Added 'request call' from processor to screen for some purpose like: navigation ...
- Updated example code
