//
//  LeaguesModel.swift
//  FootballLeaguesApp
//
//  Created by yasmeen on 10/14/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import Foundation
class LeaguesModel{
    
    private var _id:String!
    private var _name:String!
    private var _start:String!
    private var _end:String!

    init(id:String, name:String, start:String!,end:String) {
        self.id = id
        self.name = name
        self.start = start
        self.end = end
    }

    public var id:String!{
        get{
            return _id
        }
        set{
            _id = newValue
        }
    }
    
    public var name:String!{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    
    public var start:String!{
        get{
            return _start
        }
        set{
            _start = newValue
        }
    }
    
    public var end:String!{
        get{
            return _end
        }
        set{
            _end = newValue
        }
    }
    public func LeagueMapper()->[String:Any]{
        var lague=[String:Any]()
        lague["id"] = self.id
        lague["name"] = self.name
        lague["start"] = self.start
        lague["end"] = self.end
        return lague
    }
    public static func mapToLeague(league:[String:Any],key:String)->LeaguesModel{
        let league = LeaguesModel(id: league["id"] as! String, name: league["name"] as! String, start: league["start"] as? String, end: league["end"] as! String)
        return league
    }
}
