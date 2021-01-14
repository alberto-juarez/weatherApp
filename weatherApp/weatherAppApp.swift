//
//  weatherAppApp.swift
//  weatherApp
//
//  Created by Alberto Juarez on 13/01/21.
//

import SwiftUI

@main
struct weatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()))
        }
    }
}
