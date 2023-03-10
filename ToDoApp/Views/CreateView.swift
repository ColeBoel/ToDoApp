//
//  CreateView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct CreateView: View {
        @Environment(\.presentationMode) var presentationMode

        @State private var itemName = ""
        @State private var selectedDate = Date()
        @State private var selectedDateText = ""
        @State private var isDatePickerVisible = false
        
        var body: some View {
            
   
                VStack{
                    Text("Create")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    VStack(alignment:.leading){
                        Text("To-Do Item Name")
                        TextField("", text: $itemName)
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
                            
                            
                            TaskAPI.postTask(postTask: postTask(postTaskDescription: itemName, postTaskDueDate: selectedDate, postTaskCompleted: 0))
                            
                            
                            
                            
                            // Reset form values
                            itemName = ""
                            selectedDate = Date()
                            presentationMode.wrappedValue.dismiss()

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


struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
