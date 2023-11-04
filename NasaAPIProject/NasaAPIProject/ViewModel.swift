//
//  ViewModel.swift
//  NasaAPIProject
//
//  Created by Diego Borrallo Herrero on 3/11/23.
//

import Foundation

class ViewModel{
    
    static let shared = ViewModel() //Singleton
    
    let iTunesUrl = "https://itunes.apple.com/search"
    let iTunesQuery = [
        "term": "Comedy",
        "media": "ebook",
        "lang": "en_us",
        "limit": "5"
    ]

    //URL y Query de Nasa (Que se puede cambiar)
    let nasaUrl = "https://api.nasa.gov/planetary/apod"
    let nasaQuery = [
        "api_key": "bqoXM3fWUpvHCweegPLhgFDEmWKWQ1sa1cPTJyQe",
        "date": "2023-11-03"
    ]
    
    struct SearchITunesResponse: Codable{
        let results: [ITunesItem]
    }
    
    func createITunesQuery(theme: String, media: String) -> [String: String]{
        var query = self.iTunesQuery
        query["term"] = theme
        query["media"] = media
        return query
    }
    
    func createNasaQuery(date: Date) -> [String: String]{
        var query = self.nasaQuery
        let stringDate = formatDate(date: date)
        query["date"] = stringDate
        return query
    }
    
    func fetchITunesItems(theme: String, media: String) async throws -> [ITunesItem]{
        
        var data = try await ServiceApi.fetchItems(url: self.iTunesUrl, matching: createITunesQuery(theme: theme, media: media))
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(SearchITunesResponse.self, from: data)
        
        return searchResponse.results
    }
    
    func fetchNasaItems(date: Date) async throws -> NasaItem{
        
        var data = try await ServiceApi.fetchItems(url: self.nasaUrl, matching: createNasaQuery(date: date))
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(NasaItem.self, from: data)
        
        return searchResponse
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}
