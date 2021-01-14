//
//  WeatherLogic.swift
//  weatherApp
//
//  Created by Alberto Juarez on 13/01/21.
//

import Foundation
import CoreLocation





public struct Weather {
    let city,temp,temp_min,temp_max,description,iconName: String
    init(response: APIResponse){
        city = response.name
        temp = "\(Int(response.main.temp))"
        temp_min = "\(Int(response.main.temp_min))"
        temp_max = "\(Int(response.main.temp_max))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}

public final class WeatherService: NSObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "XXX"
    private var completitionHandler: ((Weather)-> Void)?
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    public func loadData(_ completitionHandler: @escaping((Weather)-> Void)){
        self.completitionHandler = completitionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    private func makeRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(self.API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url){data,response,error in
            guard error == nil, let data = data else {return}
            if let response = try? JSONDecoder().decode(APIResponse.self,from: data){
                let weather = Weather(response: response)
                self.completitionHandler?(weather)
            }
            
        }.resume()
        

    }
    

}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else {return}
        makeRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Errrorrrr: \(error.localizedDescription)")
    }
}


struct APIResponse: Codable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIWeather: Codable {
    let description: String
    let iconName: String
    enum CodingKeys: String,CodingKey{
        case description
        case iconName = "main"
    }
}

struct APIMain: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}
