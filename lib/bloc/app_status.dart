abstract class AppStatus {
  const AppStatus();
}

class InitialAppStatus extends AppStatus {
  const InitialAppStatus();
}

class AppLoggedInStatus extends AppStatus {}

class AppLoggedOutStatus extends AppStatus {}

class ChangeClosed extends AppStatus {}
