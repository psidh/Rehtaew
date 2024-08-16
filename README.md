# rehtaew

Weather application in Flutter

### Format for writing an API call in Flutter

```dart
Future<void> fetchData(String city) async {
    final apiUrl = URL

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // similar to JSON.parse in JavaScript and await
        final jsonData = json.decode(response.body);
        setState(() {
         //do the thing
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }
```

