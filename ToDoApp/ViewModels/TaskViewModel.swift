//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: Tasks?
    
    init(){
          TaskAPI.fetchTasks(completed: false, sortBy: "") { fetchedTasks, error in
            if let error = error {
                print("Error fetching tasks: \(error.localizedDescription)")
            } else if let fetchedTasks = fetchedTasks {
                DispatchQueue.main.async {
                    print("Task 0 Description = \(fetchedTasks[0].taskDescription)")
                   // self.tasks = fetchedTasks
                    self.tasks = Tasks(tasks: fetchedTasks)
                    
                }
                
            }
        }
    }
    
//    
//    func addTask(_ task: Task) {
//            tasks.append(task)
//        }
//
//    func updateTask(_ task: Task) {
//        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
//                tasks[index] = task
//            }
//    }
//
//        func deleteTask(_ task: Task) {
//            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
//                tasks.remove(at: index)
//            }
//        }
    
}
