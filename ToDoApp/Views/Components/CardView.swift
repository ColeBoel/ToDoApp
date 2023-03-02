//
//  CardView.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import SwiftUI

struct CardView: View {
    @State var isChecked = false
    var taskDescription : String
    var taskDueDate: String
    var taskCreatedDate: String
   
    
    var body: some View {
        
        LazyHStack{
            
            //Edit Button
            NavigationLink{ EditView()}label:{
                    Image(systemName: "pencil")
                    .modifier(IconViewModifier())}
            
       
            //End Edit Button
            
            
            //Title Stack
            VStack(alignment: .leading){
                Text("\(taskDescription)")
                    .font(.title3)
                    .bold()
                
                Text("Due:\(taskDueDate)")
                    
                Text("Created:\(taskCreatedDate)")
            }
            //End Title Stack
            .frame(width: UIScreen.main.bounds.width * 0.50,alignment: .leading)
            
            //CheckBox
            CheckBoxView(isChecked: $isChecked)
                .onTapGesture{isChecked.toggle()}
            //End Checkbox
            
            
            //Delete Todo
            Button{
                //Remove Todo from vm.taskList
                
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
