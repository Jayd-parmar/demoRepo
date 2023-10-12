//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by Jaydip Parmar on 25/09/23.
//

import Foundation

public enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}

class WeatherViewModel: WeatherData {
    var eventHandler: ((Event) -> Void)?
    
    var weatherData: WeatherResponse?
    
    
    func getWeatherData() {
        self.eventHandler?(.loading)
        APIManager.shared.request(
            modelType: WeatherResponse.self,
            type: EndPointItems.weather
        ){ response in
            self.eventHandler?(.stopLoading)
                switch response {
                case .success(let weather):
                    self.weatherData = weather
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
        }
    }
    
    func fetchWeatherData(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
    }
}

extension WeatherViewModel {
    
}

public protocol WeatherData {
    func getWeatherData()
    var weatherData: WeatherResponse? { get }
    var eventHandler: ((_ event: Event) -> Void)? { get set}
    func fetchWeatherData(completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}
