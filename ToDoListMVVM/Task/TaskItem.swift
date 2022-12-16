//
//  TaskItem.swift
//  ToDoListMVVM
//
//  Created by Arailym on 17.04.2022.
//

import Foundation

class TaskItem: Codable {
    var taskName: String = ""
    var istaskComplete: Bool = false
    
    init(){}
}
