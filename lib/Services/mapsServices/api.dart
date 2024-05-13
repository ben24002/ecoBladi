const String apiKey =
    "5b3ce3597851110001cf62481c44ae0813954106a4192fcbced442f2";
const String baseUrl =
    "https://api.openrouteservice.org/v2/directions/driving-car";

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}
