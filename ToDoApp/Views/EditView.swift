//
//  EditView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct EditView: View {
    
        @Environment(\.presentationMode) var presentationMode
        var task: Task
        @State var selectedDate : Date
        @State private var itemName = ""
        @State private var selectedDateText = ""
        @State private var isDatePickerVisible = false
        
        var body: some View {
                
                VStack{
                    Text("Edit")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    VStack(alignment:.leading){
                        Text("To-Do Item Name")
                        TextField("\(task.taskDescription)", text: $itemName)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            
                        
                        Text("Select Due Date")
                        
                        //Due Date Selector Hstack
                            HStack{
                                TextField(dateFormatter.string(from: selectedDate), text: $selectedDateText)
                                    .foregroundColor(.black)
                                    .padding()
                                    
                    
                                Button(action: {
                                    isDatePickerVisible = true
                                }) {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.black)
                                }
                                .padding()
                                .sheet(isPresented: $isDatePickerVisible) {
                                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                        .datePickerStyle(.graphical)
                                        .labelsHidden()
                                        .frame(width: 300, height: 300)
                                }
                            }
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                        //End Due Date Selector Hstack

                    }
                    .padding(.horizontal)
                    
                    
                    HStack{
                        Button(action: {
                     
                                            TaskAPI.editTask(updatedTask: Task(id: task.id, taskDescription: itemName == "" ? task.taskDescription : itemName, createdDate: task.createdDate, dueDate: convertDateString(selectedDate.description) ?? Date.now.description, completed: task.completed)) { task, error in
                            if let error = error {
                                print("💨Error: \(error)")
                                return
                            }
                            if let task = task {
                                print("Updated task: \(task)")
                                presentationMode.wrappedValue.dismiss()

                            }
                        }
                           
                        }) {
                            Text("Save")
                                .padding()
                                .frame(width: 100)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(10)
                                
                        }
                    }
                    .padding(30)
                    Spacer()
                }
            }
    }

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(task: Task(id: "1252", taskDescription: "Laundry", createdDate: "12-07-12", dueDate: "12-07-12", completed: 0))
//    }
//}
