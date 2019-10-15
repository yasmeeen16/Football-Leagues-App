//
//  LeaguesViewModel.swift
//  FootballLeaguesApp
//
//  Created by yasmeen on 10/15/19.
//  Copyright © 2019 yasmeen. All rights reserved.
//

import Foundation

class LeaguesViewModel{
    var LeaguesArray = [LeaguesModel]()
    
    init() {
        API.GetData(){(error : Error?, success : Bool? , data:[LeaguesModel]?)  in
            if success! {
                print("success")
                self.LeaguesArray = data!
                //print(self.LeaguesArray)
            }else{
                print("failed")
            }
        }
    }

}
