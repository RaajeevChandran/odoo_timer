import 'dart:async';

class Timesheet {
  // unique identifier
  final int id;

  bool isRunning, isCompleted;

  final bool isFavorite;

  final Stopwatch stopwatch;

  // facilitates the updation of elapsed time in the UI by running it periodically for each second
  Timer? timer;

  final String taskId;

  String description;

  final StreamController<String> _elapsedTimeStreamController =
      StreamController<String>();

  Stream<String> get elapsedTimeStream => _elapsedTimeStreamController.stream;

  Timesheet(
      {required this.id,
      required this.isFavorite,
      required this.taskId,
      this.isRunning = false,
      this.isCompleted = false,
      this.description = ""})
      : stopwatch = Stopwatch() {
    if (isRunning) {
      _startTimer();
    }
  }

  void toggle() {
    if (isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  //private helper function that formats the time elapsed as 00:00 (mm:ss)
  String get _elapsedTime {
    final elapsedMinutes = stopwatch.elapsed.inMinutes.remainder(60);
    final elapsedSeconds = stopwatch.elapsed.inSeconds.remainder(60);
    return '${elapsedMinutes.toString().padLeft(2, '0')}:${elapsedSeconds.toString().padLeft(2, '0')}';
  }

  // pushes the elapsed seconds in the form of a formatted string to the Stream
  void _startTimer() {
    if (!isRunning) {
      isRunning = true;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _elapsedTimeStreamController.add(_elapsedTime);
      });
      stopwatch.start();
    }
  }

  void _stopTimer() {
    if (isRunning) {
      isRunning = false;
      timer?.cancel();
      stopwatch.stop();
    }
  }

  void dispose() {
    _elapsedTimeStreamController.close();
  }
}
