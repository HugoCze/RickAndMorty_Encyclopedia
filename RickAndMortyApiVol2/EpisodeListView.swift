//
//  ContentView.swift
//  RickAndMortyApiVol2
//
//  Created by Hugo Czerniawski on 23/04/2022.
//

import SwiftUI

struct EpisodeListView: View {
    
    @State var episodes: [Episode] = []
    
    var body: some View {
        if episodes.count == 0 {
            VStack {
                ProgressView()
                    .padding()
                Text("Space vaccum activated...")
                    .foregroundColor(.mint)
                    .onAppear(perform: {
                        getEpisodes()
                    })
            }
        }
        else { List(episodes) {
            listedEpisodes in
            Text(listedEpisodes.name)
                .bold()
            }
        }
    }
    
    func getEpisodes() {
        
        let api = "https://rickandmortyapi.com/api"
        let arr1 = Array(1...51)
        let stringRepresentation = arr1.map { String($0) }.joined(separator: ",")
        let endpoint = "/episode/\(stringRepresentation)"
        let format = "?format=json"
        let RMAPIURL = api + endpoint + format
        print(RMAPIURL)
        if let apiURL = URL(string: RMAPIURL) {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                
                if error != nil {
                    print("There was an error!..")
                } else if data != nil {
                    //                    print(String(data: data!, encoding: .utf8) ?? "Error")
                    if let episodes_from_API = try? JSONDecoder()
                        .decode([Episode].self, from: data!)   {
                        //                        print("Episode from API: ")
                        //                        print(episodes_from_API)
                        episodes = episodes_from_API
                    }
                    
                }
                
            }.resume()
        }
    }
}

struct Episode: Codable, Identifiable  {
    var id: Int
    var name: String
    var air_date: String
    var episode: String
    var created: String
    
}

struct ContentView_Previews_Episode: PreviewProvider {
    static var previews: some View {
        EpisodeListView()
    }
}
