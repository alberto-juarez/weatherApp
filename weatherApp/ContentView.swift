//
//  ContentView.swift
//  weatherApp
//
//  Created by Alberto Juarez on 13/01/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors:[Color.blue,Color(red: 210/255, green: 224/255, blue: 255/255)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            VStack(spacing:15){
                Spacer()
                Text(viewModel.cityname)
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                VStack(spacing: 20){
                    Text(viewModel.weatherIcon)
                        .font(.system(size: 100))
                        .bold()
                        .foregroundColor(.white)
                    Text("Current")
                        .foregroundColor(.white)
                        .font(.footnote)
                    Text("\(viewModel.temperature)ºC")
                        .font(.system(size: 35))
                        .bold()
                        .foregroundColor(.white)
                    
                    HStack(spacing: 30){
                        VStack{
                            Text("Min")
                                .foregroundColor(.white)
                                .font(.footnote)
                            Text("\(viewModel.temperature_min)ºC")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }
                        
                        VStack{
                            Text("Max")
                                .foregroundColor(.white)
                                .font(.footnote)
                            Text("\(viewModel.temperature_max)ºC")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
            }
            
            
        }.onAppear(perform:viewModel.refresh)
    }
}

struct dayView: View {
    var body: some View{
        VStack{
            Text("LUN")
                .font(.system(size: 15))
                .foregroundColor(.white)
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .font(.system(size: 30))
                .frame(width: 50, height: 50)
            Text("Current").font(.footnote)
            Text("34ºC")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.white)
            HStack{
                VStack{
                    Text("Min").font(.footnote)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()))
            ContentView(viewModel: WeatherViewModel(weatherService: WeatherService()))
        }
    }
}
