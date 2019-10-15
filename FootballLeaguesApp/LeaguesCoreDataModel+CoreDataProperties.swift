//
//  LeaguesCoreDataModel+CoreDataProperties.swift
//  
//
//  Created by yasmeen on 10/15/19.
//
//

import Foundation
import CoreData


extension LeaguesCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LeaguesCoreDataModel> {
        return NSFetchRequest<LeaguesCoreDataModel>(entityName: "LeaguesCoreDataModel")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var start: String?
    @NSManaged public var end: String?

}
