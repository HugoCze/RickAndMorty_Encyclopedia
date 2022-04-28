//
//  StartView.swift
//  RickAndMortyApiVol2
//
//  Created by Hugo Czerniawski on 28/04/2022.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        
        
        NavigationView {
            ZStack {
                List {
                    
                    NavigationLink(destination: CharactersListView()) {
                        Label("Characters", systemImage: "person.3.fill")
                    }
                    NavigationLink(destination: EpisodeListView())
                    {
                        Label("Episodes", systemImage: "display")
                    }
                    
                    NavigationLink(destination: LocationListView())
                    {
                        Label("Locations", systemImage: "globe.asia.australia.fill")
                    }

                }
                .navigationTitle("Categories: ")
       
            }
            .frame(maxWidth: .infinity)

        }
    }
    struct StartView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
        }
    }
}


