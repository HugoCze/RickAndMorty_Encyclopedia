//
//  ContentView.swift
//  RickAndMortyApiVol2
//
//  Created by Hugo Czerniawski on 23/04/2022.
//

import SwiftUI

struct LocationListView: View {


    
    @State var locations: [Location] = []
    
    var body: some View {
        if locations.count == 0 {
            VStack {
                ProgressView()
                    .padding()
                Text("Space vaccum activated...")
                    .foregroundColor(.mint)
                    .onAppear(perform: {
                        getLocations()
                    })
            }
        }
        else { List(locations) {
            listedLocations in
            Text(listedLocations.name)
                .bold()
            
            }
        }
    }
    
    func getLocations() {
        
        let api = "https://rickandmortyapi.com/api"
        let arr1 = Array(1...126)
        let stringRepresentation = arr1.map { String($0) }.joined(separator: ",")
        let endpoint = "/location/\(stringRepresentation)"
        let format = "?format=json"
        let RMAPIURL = api + endpoint + format
        
        if let apiURL = URL(string: RMAPIURL) {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                
                if error != nil {
                    print("There was an error!..")
                } else if data != nil {
                    //                    print(String(data: data!, encoding: .utf8) ?? "Error")
                    if let locations_from_API = try? JSONDecoder()
                        .decode([Location].self, from: data!)   {
                        print("Locations from API: ")
                        print(locations_from_API)
                        locations = locations_from_API
                    }
                    
                }
                
            }.resume()
        }
    }
}

struct Location: Codable, Identifiable  {
    var id: Int
    var name: String
    var type: String
    var dimension: String
    var created: String
    
}

struct ContentView_Previews_Location: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
