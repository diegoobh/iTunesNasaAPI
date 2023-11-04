//
//  ITunesView.swift
//  NasaAPIProject
//
//  Created by Diego Borrallo Herrero on 4/11/23.
//

import SwiftUI

struct ITunesView: View{
    
    var viewModel = ViewModel()
    
    @State var option = 0
    @State var items: [ITunesItem] = []
    @State var theme = ""
    
    let options = ["music", "movie", "podcast", "musicVideo", "audiobook", "shortFilm", "tvShow", "software", "ebook", "all"]
    
    @Binding var view: Int
    
    var body : some View {
        VStack{
            HStack{
                VStack{
                    Button("iTunes"){
                        self.view = 0
                    }
                    .frame(width: 180, height: 20)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Rectangle()
                        .frame(width: 180, height: 5)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                VStack{
                    Button("NASA"){
                        self.view = 1
                    }
                    .frame(width: 180, height: 20)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    Rectangle()
                        .frame(width: 180, height: 5)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            
            Text("Buscador de multimedia")
                .fontWeight(.bold)
                .padding()
            HStack{
                Text("Tipo de multimedia")
                Picker("Seleccione una opción", selection: $option){
                    ForEach(0 ..< options.count, id: \.self){
                        index in
                        Text(self.options[index]).tag(index)
                    }
                }.pickerStyle(MenuPickerStyle())
            }
                TextField("Introduzca el nombre", text: $theme)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                Button("Cargar datos"){
                    Task{
                        self.items = []
                        self.items = try await viewModel.fetchITunesItems(theme: self.theme,
                                     media: self.options[self.option])
                        self.theme = ""
                    }
                }
                List(items, id: \.name){ item in
                    VStack(alignment: .leading){
                        Text(item.name)
                            .font(.headline)
                        Text(item.artist)
                            .font(.subheadline)
                        Text(item.kind)
                            .font(.subheadline)
                        AsyncImage(url: item.artworkURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }placeholder: {
                            ProgressView()
                        }
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


