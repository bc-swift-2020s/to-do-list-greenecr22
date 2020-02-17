//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Christopher Greene on 2/10/20.
//  Copyright © 2020 Christopher Greene. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
}
