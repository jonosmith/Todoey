//
//  Category.swift
//  Todoey
//
//  Created by Jonathan Smith on 6/7/19.
//  Copyright © 2019 Jonathan Smith. All rights reserved.
//

import Foundation
import RealmSwift
import ChameleonFramework

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = UIColor.randomFlat.hexValue()
    
    let items = List<Item>()

}
