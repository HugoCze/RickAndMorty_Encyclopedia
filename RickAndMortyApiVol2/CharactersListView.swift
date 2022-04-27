//
//  ContentView.swift
//  RickAndMortyApiVol2
//
//  Created by Hugo Czerniawski on 23/04/2022.
//

import SwiftUI

struct CharactersListView: View {
    
    @State var characters: [Character] = []
    
    var body: some View {
        if characters.count == 0 {
            VStack {
                ProgressView()
                    .padding()
                Text("Space vaccum activated...")
                    .foregroundColor(.mint)
                    .onAppear(perform: {
                        getCharacters()
                    })
            }
        } else {
            ScrollView {
                VStack(spacing:0) {
                    ForEach(characters) {listedCharacters in
                        CharacterTileView(character: listedCharacters)
                            
                    }
                }
            }
        }
    }
    
    
    func getCharacters() {
        
        let api = "https://rickandmortyapi.com/api"
        let arr1 = Array(1...200)
        let stringRepresentation = arr1.map { String($0) }.joined(separator: ",")
        let endpoint = "/character/\(stringRepresentation)"
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
                    if let characters_from_API = try? JSONDecoder()
                        .decode([Character].self, from: data!)   {
                        //                        print("Characters from API: ")
                        //                        print(characters_from_API)
                        characters = characters_from_API
                    }
                }
                
            }.resume()
        }
    }
}

struct Character: Codable, Identifiable  {
    var id: Int
    var name: String
    var image: String
    var species: String
    //    var location: Dictionary
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
