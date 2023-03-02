//
//  MainPageView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct MainPageView: View {
    @ObservedObject var vm = TaskViewModel()
    
    
    var body: some View {
        
       VStack{
            
            TitleView()
            
           ScrollView{
            if let tasks = vm.tasks {
                
                ForEach(tasks.tasks, id: \.id) { task in
                
                       CardView(taskDescription: task.taskDescription, taskDueDate: task.dueDate, taskCreatedDate: task.createdDate)
                    
                    }
                }// End If
               
            }.background(.clear)

            
        }
        .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.90, alignment: .top)
        
        
        
        
        
    }

}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
