//
//  CharacterTileView.swift
//  RickAndMortyApiVol2
//
//  Created by Hugo Czerniawski on 27/04/2022.
//

import SwiftUI

struct CharacterTileView: View {
    
    var character: Character
    
    var body: some View {
        //            Text(listedCharacters.name)
        ZStack {
            AsyncImage(url: URL(string: character.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    
                    VStack {
                        ProgressView()
                        //                                Image(systemName: "hourglass")
                        //                                    .font(.largeTitle)
                            .padding(80)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.mint)
                    
                }
            }
            VStack {
                Spacer()
                HStack {
                    
                    Text("Name: " + character.name)
                        .bold()
                        .foregroundColor(.white)
                        .padding(5)
                    Text("Specie: " + character.species)
                        .bold()
                        .foregroundColor(.white)
                        .padding(5)
                    Spacer()
                }
                .background(Color.mint.opacity(0.8))
            }
        }
    }
}

struct CharacterTileView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterTileView(character: Character(id: 5, name: "Rick", image: "api.RickImage.com", species: "Human", status: "Alive", type: "God", gender: "Male", created: "Date of database addition"))
    }
}

