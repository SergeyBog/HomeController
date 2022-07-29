//
//  DeviceDbModel+CoreDataProperties.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 26.07.2022.
//
//

import Foundation
import CoreData


extension DeviceDbModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceDbModel> {
        return NSFetchRequest<DeviceDbModel>(entityName: "DeviceDbModel")
    }

    @NSManaged public var deviceName: String?
    @NSManaged public var id: Int16
    @NSManaged public var intensity: Int16
    @NSManaged public var mode: String?
    @NSManaged public var position: Int16
    @NSManaged public var productType: String?
    @NSManaged public var temperature: Float

}

extension DeviceDbModel : Identifiable {

}
