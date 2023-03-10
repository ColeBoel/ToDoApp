//
//  dateFormatter.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/7/23.
//

import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()

func convertDateString(_ dateString: String) -> String? {
    let inputFormat = "yyyy-MM-dd HH:mm:ss Z"
    let outputFormat = "MMMM, d, yyyy"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    } else {
        return nil
    }
}

func convertDueDateString(_ dateString: String) -> String? {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dateString)

    dateFormatter.dateFormat = "MMM d, yyyy"
    let formattedDate = dateFormatter.string(from: date!)

    return formattedDate
}



