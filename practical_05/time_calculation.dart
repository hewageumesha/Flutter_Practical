void main() {
  double distance = 25; // km
  double speed = 40; // km/h

  double timeHours = distance / speed;
  double timeMinutes = timeHours * 60;

  print("Time to reach office: $timeMinutes minutes");
}