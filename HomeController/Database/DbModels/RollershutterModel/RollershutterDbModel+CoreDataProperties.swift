//
//  RollershutterDbModel+CoreDataProperties.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 01.08.2022.
//
//

import Foundation
import CoreData


extension RollershutterDbModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RollershutterDbModel> {
        return NSFetchRequest<RollershutterDbModel>(entityName: "RollershutterDbModel")
    }

    @NSManaged public var deviceName: String?
    @NSManaged public var id: Int16
    @NSManaged public var position: Int16
    @NSManaged public var mode: String?

}

extension RollershutterDbModel : Identifiable {

}
