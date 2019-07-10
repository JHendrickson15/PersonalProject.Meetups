//
//  EventsController.swift
//  PersonProject
//
//  Created by Jordan Hendrickson on 7/9/19.
//  Copyright © 2019 Jordan Hendrickson. All rights reserved.
//

import UIKit


class EventsController{
    
    static let shared = EventsController()
    
    var events: [Events] = []
    
    func fetchEvents(searchTerm: String, completion: @escaping ([Events]?) -> Void) {
        
        guard let baseURL = URL(string: "https://app.ticketmaster.com/discovery/v2/events.json?") else {return}
        
        let url = URLRequest(url: baseURL)
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let sizeQuery = URLQueryItem(name: "size", value: "50")
        let postalQuery = URLQueryItem(name: "postalCode", value: searchTerm)
        let radiusQuery = URLQueryItem(name: "radius", value: "19998")
        let unitQuery = URLQueryItem(name: "unit", value: "miles")
        let apiquery = URLQueryItem(name: "apikey", value: "68ByMlWbaQQ5CTus0dGkcJ8u4hKGEz7D")
        components?.queryItems = [sizeQuery, postalQuery, radiusQuery, unitQuery, apiquery]
        
        guard let finalURL = components?.url else {completion(nil); return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("cannot fetch events. \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {return}
            print(data.printableJSONString)
            let decoder = JSONDecoder()
            
            do{
                let topLevelJSON = try decoder.decode(TopLevelJSON.self, from: data)
                let embeddedDict = topLevelJSON._embedded
                let events = embeddedDict.events
                
                
                completion(events)
            }catch{
                print("error decoding")
                
                return
            }
            
            }.resume()
        
    }
}
