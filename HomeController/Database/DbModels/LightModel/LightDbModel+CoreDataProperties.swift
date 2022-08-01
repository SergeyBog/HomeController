//
//  LightDbModel+CoreDataProperties.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 01.08.2022.
//
//

import Foundation
import CoreData


extension LightDbModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LightDbModel> {
        return NSFetchRequest<LightDbModel>(entityName: "LightDbModel")
    }

    @NSManaged public var deviceName: String?
    @NSManaged public var id: Int16
    @NSManaged public var intensity: Int16
    @NSManaged public var mode: String?

}

extension LightDbModel : Identifiable {

}
