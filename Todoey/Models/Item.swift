//
//  Item.swift
//  Todoey
//
//  Created by Jonathan Smith on 6/7/19.
//  Copyright © 2019 Jonathan Smith. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")  
}
