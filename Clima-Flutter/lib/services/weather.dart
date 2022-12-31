import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = "1b6d0fb554ef33969eaf8d569823ab4c";
const weatherMapURl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    Networking network = Networking('$weatherMapURl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    return await network.getData();
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url = "$weatherMapURl?q=$cityName&appid=$apiKey&units=metric";
    Networking network = Networking(url);
    var weatherData = await network.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
