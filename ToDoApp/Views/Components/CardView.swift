//
//  CardView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct CardView: View {
    
    @State var isChecked : Bool
    var task : Task
    @State var formattedDueDate = ""
    @ObservedObject var vm : TaskViewModel

    
    var body: some View {
        
        LazyHStack{
            
            //Edit Button
            NavigationLink{EditView(task: task, selectedDate: dateFormatter.date(from: task.dueDate) ?? Date.now)}label:{
                    Image(systemName: "pencil")
                    .modifier(IconViewModifier())}
            
            //End Edit Button
            
            
            //Title Stack
            VStack(alignment: .leading){
                Text("\(task.taskDescription)")
                    .font(.title3)
                    .bold()
                
                Text("Due: \(formattedDueDate)")
                    
                Text("Created: \(task.createdDate)")
            }
            
            .onAppear{
                formattedDueDate = convertDueDateString(task.dueDate) ?? task.dueDate
            }
            //End Title Stack
            .frame(width: UIScreen.main.bounds.width * 0.50,alignment: .leading)
            
            //CheckBox
            CheckBoxView(isChecked: $isChecked)
                .onTapGesture{
                    isChecked.toggle()
                    
                    TaskAPI.editTask(updatedTask: Task(id: task.id, taskDescription: task.taskDescription, createdDate: task.createdDate, dueDate: task.dueDate, completed: abs(task.completed - 1))) { task, error in
                    if let error = error {
                        print("💨Error: \(error)")
                        return
                    }
                    if let task = task {
                        
                        print("Updated task: \(task)")
                        }
                    }
                    vm.refresh()
                    
                }
            //End Checkbox
            
            
            //Delete Todo
            Button{
                //Remove Todo from vm.taskList
                TaskAPI.deleteTask(id: task.id) { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        print("🗑️🗑️🗑️ Task deleted successfully!🗑️🗑️🗑️")
                    }
                }
                
                vm.refresh()
            }label: {
                Image(systemName: "trash.fill")
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
            //End Delete
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.90, height: 90, alignment: .leading)
        .background{
           Rectangle()
                .foregroundColor(.gray.opacity(0.50))
                .cornerRadius(10)
        }
     
        
        
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(taskDescription: "Write Offer Letter", taskDueDate: .now, taskCreatedDate: .now)
//    }
//}
