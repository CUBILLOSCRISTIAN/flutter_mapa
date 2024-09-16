const String baseUrl = 'http://192.168.1.20:3000/route';
const String apiKey = 'api_key=5b3ce3597851110001cf6248e0cde69c11214eb0bf6fc96597a3aa96';

getRouterURL(String? startPoint, String? endPoint){
  return Uri.parse('$baseUrl');
}