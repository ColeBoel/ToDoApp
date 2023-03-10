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
    var completed: Int
}


struct postTask: Codable {
    let postTaskDescription: String
    let postTaskDueDate: Date
    let postTaskCompleted: Int
}
