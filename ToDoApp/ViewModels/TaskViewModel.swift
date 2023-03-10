//
//  TaskViewModel.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task]?
    @Published var all = true
    @Published var completed = false
    @Published var incomplete = false
    @Published var due = true
    @Published var created = false
    @Published var ascending = true
    @Published var descending = false

    
    
    //Fetching all tasks upon init
    init(){
        refresh()
    }
    //End Init
    
    func refresh(){
        
        var completedFilter : Int? = nil
        var sortby: String? = nil
        
        if completed{
            completedFilter = 1
        } else if incomplete{
            completedFilter = 0
        }
        
        if descending{
            sortby = "-"
        } else if ascending {
            sortby = ""
        }
        
        if due{
            sortby! += "dueDate"
        } else if created && sortby != nil{
            sortby! += "createdDate"
        }
        
       
        print(sortby)
        
        
        TaskAPI.fetchTasks(completed: completedFilter, sortBy: sortby) { fetchedTasks, error in
          if let error = error {
              print("Error fetching tasks: \(error)")
          } else if let fetchedTasks = fetchedTasks {
              DispatchQueue.main.async {
                  self.tasks = fetchedTasks
              }
              
          }
      }
    }
    
   
    
    
    
    
    
}
