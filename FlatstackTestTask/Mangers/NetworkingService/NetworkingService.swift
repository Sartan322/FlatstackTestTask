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
    private var dataManager = DataManager()
    
    static func shared() -> NetworkingService {
        if uniqueInstanse == nil {
            uniqueInstanse = NetworkingService()
        }
        return uniqueInstanse!
    }
    
    var url: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    func doRequest(url: String, count: Int, completion: ( ([Country]) -> Void)?){
        AF.request(url).response {response in
            switch response.result {
            case .success(let jsonData):
                let json = JSON(jsonData)
                for (_, value) in json["countries"] {
                    print(value["name"].string!)
                    self.dataManager.addCountry(country: Countries(name: value["name"].string!,
                                                              continent: value["continent"].string!,
                                                              capital: value["capital"].string!,
                                                              population: String(value["population"].int!),
                                                              descriptionSmall: value["description_small"].string ?? nil,
                                                              description: value["description"].string!,
                                                              image: value["image"].string!,
                                                              images: value["country_info"]["images"].string ?? nil,
                                                              flag: value["country_info"]["flag"].string!, next: json["next"].string))
                    
                }
                completion!(self.dataManager.getNext(count: (count - 1)))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteAll(){
        dataManager.deleteAll()
    }
    
}
