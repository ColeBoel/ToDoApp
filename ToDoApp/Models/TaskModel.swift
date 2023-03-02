//
//  TaskModel.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: String
    let taskDescription: String
    let createdDate: String
    let dueDate: String
    var completed: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case taskDescription
        case createdDate
        case dueDate
        case completed
    }

    
}

struct Tasks: Codable {
    var tasks: [Task]
}
