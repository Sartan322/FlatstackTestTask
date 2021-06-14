//
//  NetworkingService.swift
//  FlatstackTestTask
//
//  Created by Павел Прокопьев on 13.06.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingService {
    
    private static var uniqueInstanse: NetworkingService?
    private init(){}
    
    static func shared() -> NetworkingService {
        if uniqueInstanse == nil {
            uniqueInstanse = NetworkingService()
        }
        return uniqueInstanse!
    }
    
    var url: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    func doRequest(url: String, completion: ( ([Countries]) -> Void)?){
        AF.request(url).response {response in
            switch response.result {
            case .success(let jsonData):
                var countries: [Countries] = []
                let json = JSON(jsonData)
                for (key, value) in json["countries"] {
                    countries.append(Countries(name: value["name"].string!,
                                               continent: value["continent"].string!,
                                               capital: value["capital"].string!,
                                               population: String(value["population"].int!),
                                               descriptionSmall: value["description_small"].string ?? nil,
                                               description: value["description"].string!,
                                               image: value["image"].string!,
                                               images: value["country_info"]["images"].string ?? nil,
                                               flag: value["country_info"]["flag"].string!, next: json["next"].string))
                }
                completion!(countries)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
