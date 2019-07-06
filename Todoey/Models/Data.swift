//
//  Data.swift
//  Todoey
//
//  Created by Jonathan Smith on 6/7/19.
//  Copyright © 2019 Jonathan Smith. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
