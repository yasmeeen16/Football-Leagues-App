//
//  API.swift
//  FootballLeaguesApp
//
//  Created by yasmeen on 10/15/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData
class API: NSObject {
    class func GetData(completion: @escaping (_ error :Error?, _ seccess :Bool?,_ data:[LeaguesModel]?) -> Void){
        let url = "http://api.football-data.org/v2/competitions"
        
        
        Alamofire.request(url, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                case .failure( let error):
                    print(error)
                    completion(error,false,nil)
                case .success( let value):
                    //print(value)
                    let json = JSON(value)
                    //completion(nil,true,)
                    guard let competitions = json["competitions"].array else{
                        completion(nil, nil, nil)
                        return
                    }

                  
                    var LeaguesModelArray = [LeaguesModel]()
                    //var CoreDataLeaguesModelArray = [LeaguesCoreDataModel]()
                    
                   
                    
                    for comp in competitions{
                        guard let comp = comp.dictionary else{return}
                        var id = "0"
                        var name = ""
                        var start = ""
                        var end = ""
                        for (key, value) in comp {
                            if key == "id"{
                                id = "\(value.int!)"
                            }
                            if key == "name"{
                                name = value.string ?? "0"
                            }
                            if key == "currentSeason"{
                                for (key, value) in value{
                                    if key == "startDate" {
                                        start = value.string ?? "0"
                                    }
                                    if key == "endDate" {
                                        end = value.string ?? "0"
                                    }
                                }
                                
                            }
                        }
                        let rowData = LeaguesModel(id: id, name:name, start: start, end: end)
                        let coreDataObject = LeaguesCoreDataModel(context: PersistenceService.context)
                        coreDataObject.id = id
                        coreDataObject.name = name
                        coreDataObject.start = start
                        coreDataObject.end = end
                        PersistenceService.saveContext()
                        LeaguesModelArray.append(rowData)
                    }
                    completion(nil, true, LeaguesModelArray)

                }
        }
    }

    
}

