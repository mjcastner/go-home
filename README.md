# GoHome
A loving and half-assed recreation of Google's Go link server.  Uses a Golang /
gRPC backend and a Dart / Flutter gRPC web frontend.  Not at all ready for
production deployments.

## Work in progress
You can see a snapshot of server functionality
[here](https://gohome-flutter-web-b5p44absla-uw.a.run.app/).

Feature list:

* Golang backend
  * ~~gRPC server~~
  * ~~gRPC test client~~
  * Bazel tests
* Flutter frontend
  * ~~gRPC web integration~~
  * Android / iOS clients
  * Settings page
  * Tests
  * ~~Home page~~
  * ~~Create link page~~
  * ~~Post-create page~~
  * ~~Initial URL validation~~
  * Better HTTP validation / handling
  * OAuth flow for Google sign-in
  * Docker hostname configuration / DNS A Record setup
* CI/CD
  * ~~GitHub Actions workflow~~
  * Testing integration