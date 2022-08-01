//
//  HeaterDbModel+CoreDataProperties.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 01.08.2022.
//
//

import Foundation
import CoreData


extension HeaterDbModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeaterDbModel> {
        return NSFetchRequest<HeaterDbModel>(entityName: "HeaterDbModel")
    }

    @NSManaged public var deviceName: String?
    @NSManaged public var id: Int16
    @NSManaged public var mode: String?
    @NSManaged public var temperature: Float

}

extension HeaterDbModel : Identifiable {

}
