
class Service {

  final apiURL = "http://10.0.2.2:8000";
  final Map<String, String> requestHeadersPost = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Headers': 'Content-Type'
  };

  final headersPost = {
    'Content-Type': 'application/json'
  };
}