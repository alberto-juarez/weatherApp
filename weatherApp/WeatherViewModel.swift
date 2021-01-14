//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by Alberto Juarez on 13/01/21.
//

import Foundation

private let iconMap = [
    "Drizzle" :"🌧",
    "Thunderstorm" :"🌧",
    "Rain" : "🌧",
    "Snow" : "❄️",
    "Clear" : "☁️",
    "Clouds" : "🌥",
]

class WeatherViewModel: ObservableObject {
    @Published var cityname: String = "City name"
    @Published var temperature: String = "--"
    @Published var temperature_min: String = "--"
    @Published var temperature_max: String = "--"
    @Published var weatherDesc: String = ""
    @Published var weatherIcon: String = ""
    
    public let weatherService: WeatherService
    init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    func refresh(){
        weatherService.loadData{ weather in
            DispatchQueue.main.async {
                self.cityname = weather.city
                self.temperature = weather.temp
                self.temperature_min = weather.temp_min
                self.temperature_max = weather.temp_max
                self.weatherDesc = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName ] ?? "❓"
            }
            
        }
    }
}
