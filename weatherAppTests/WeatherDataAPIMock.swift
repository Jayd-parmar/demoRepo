//
//  WeatherDataAPIMock.swift
//  weatherAppTests
//
//  Created by Jaydip Parmar on 03/10/23.
//

import Foundation
import XCTest
import weatherApp

//enum error: Error {
//    
//}

class WeatherDataMock: WeatherData {
    
    var weatherData: weatherApp.WeatherResponse?
    var eventHandler: ((weatherApp.Event) -> Void)?
    let weatherJSON = """
    {
        "coord": {
            "lon": -0.13,
            "lat": 51.51
        },
        "weather": [
            {
                "id": 300,
                "main": "Drizzle",
                "description": "light intensity drizzle",
                "icon": "09d"
            }
        ],
        "base": "stations",
        "main": {
            "temp": 280.32,
            "pressure": 1012,
            "humidity": 81,
            "temp_min": 279.15,
            "temp_max": 281.15
        },
        "visibility": 10000,
        "wind": {
            "speed": 4.1,
            "deg": 80
        },
        "clouds": {
            "all": 90
        },
        "dt": 1485789600,
        "sys": {
            "type": 1,
            "id": 5091,
            "message": 0.0103,
            "country": "GB",
            "sunrise": 1485762037,
            "sunset": 1485794875
        },
        "id": 2643743,
        "name": "London",
        "cod": 200
    }
""".data(using: .utf8)!

    func getWeatherData() {
//        do {
//
//        } catch {
//            print("Fatal error while decoding weather data \(error)")
//        }
//        let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: weatherJSON)
//        weatherData = weatherResponse
//        self.eventHandler?(.dataLoaded)
    }
    
    func fetchWeatherData(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: weatherJSON)
        weatherData = weatherResponse
//        self.eventHandler?(.dataLoaded)
        completion(.success(weatherData!))
//        completion(.failure())
    }

}
 
