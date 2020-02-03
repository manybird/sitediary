# sitediary
PSL Site Diary

  One-time code generation
  By running [flutter packages pub run build_runner  build] in the project root(cmd), you generate JSON serialization code for your models whenever they are needed. 
  This triggers a one-time build that goes through the source files, picks the relevant ones, and generates the necessary serialization code for them.

  While this is convenient, it would be nice if you did not have to run the build manually every time you make changes in your model classes.

  Generating code continuously
  A watcher makes our source code generation process more convenient. 
  It watches changes in our project files and automatically builds the necessary files when needed. 
  Start the watcher by running [flutter packages pub run build_runner watch] in the project root(cmd).

   [flutter packages pub run build_runner watch --delete-conflicting-outputs]


  It is safe to start the watcher once and leave it running in the background.
  
  The Flutter plugin includes the following templates:
  
  Prefix [stless]: Create a new subclass of StatelessWidget.
  Prefix [stful]: Create a new subclass of StatefulWidget and its associated State subclass.
  Prefix [stanim]: Create a new subclass of StatefulWidget and its associated State subclass, including a field initialized with an AnimationController.
  You can also define custom templates in [Settings > Editor > Live Templates].

IOS
[https://flutter.dev/docs/get-started/install/macos]
open ios/runner.xcworkspace
Flutter run

[https://stackoverflow.com/questions/53450817/flutter-type-uiapplication-has-no-member-opensettingsurlstring/53453243#53453243]

use_frameworks!  # required by Geolocator
config.build_settings['SWIFT_VERSION'] = '4.2'  # required by Geolocator
