//
//  TaskAPI.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import Foundation

class TaskAPI {
    
    static let baseUrl = "http://localhost:3000"
    
    static func fetchTasks(completed: Int?, sortBy: String?, completionHandler: @escaping ([Task]?, Error?) -> Void) {

        // Construct the API endpoint URL with query parameters
        var endpointUrl = "\(baseUrl)/tasks"
        
        if let sortBy = sortBy, let completed = completed {
            endpointUrl += "?completed=\(completed)&sort_by=\(sortBy)"
        } else if let completed = completed {
            endpointUrl += "?completed=\(completed)"
        }else if let sortBy = sortBy {
            endpointUrl += "?sort_by=\(sortBy)"
        }
        
        print("ENDPOINT URL: \(endpointUrl)")
        
        guard let url = URL(string: endpointUrl) else {
            completionHandler(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        // Create a GET request for the endpoint
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            // Handle errors
            if let error = error {
                completionHandler(nil, error)
                return
            }

            // Check response status code
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completionHandler(nil, NSError(domain: "Server error", code: httpResponse.statusCode, userInfo: nil))
                return
            }

            // Parse the response data into an array of Task objects
            if let data = data {
                do {
                    let tasks = try JSONDecoder().decode([Task].self, from: data)
                    print("Data: \(tasks)")
                    completionHandler(tasks, nil)
                } catch {
                    print(error)
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }

    
    static func fetchTask(id: String, completionHandler: @escaping (Task?, Error?) -> Void) {
        
        // Construct the API endpoint URL
        let endpointUrl = "\(baseUrl)/tasks/\(id)"
        guard let url = URL(string: endpointUrl) else {
            completionHandler(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        // Create a GET request for the endpoint
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Handle errors
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            // Parse the response data into a Task object
            if let data = data {
                do {
                    let task = try JSONDecoder().decode(Task.self, from: data)
                    completionHandler(task, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    
    static func postTask(postTask: postTask){
        
        
        // Create the request
        let url = URL(string: "\(baseUrl)/tasks")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        print("😀 POST TASK: \(postTask)")

   
        let jsonData = try? JSONEncoder().encode(postTask)
        request.httpBody = jsonData
        
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                print("Error: \(httpResponse.statusCode)")
                return
            }
            
            if let data = data {
                let responseJSON = try! JSONSerialization.jsonObject(with: data, options: [])
                print("😀 POST TASK RESPONSE JSON: \(responseJSON)")
            }
        }

        task.resume()
    }
    
    static func deleteTask(id: String, completionHandler: @escaping (Error?) -> Void) {
        // Construct the API endpoint URL
        let endpointUrl = "\(baseUrl)/tasks/\(id)"
        guard let url = URL(string: endpointUrl) else {
            completionHandler(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        // Create a DELETE request for the endpoint
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        // Send the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                completionHandler(error)
                return
            }

            // Check response status code
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(NSError(domain: "Invalid response", code: 0, userInfo: nil))
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completionHandler(NSError(domain: "Server error", code: httpResponse.statusCode, userInfo: nil))
                return
            }

            completionHandler(nil)
        }
        task.resume()
    }
    
    static func editTask(updatedTask: Task, completionHandler: @escaping (Bool?, Error?) -> Void) {
            
            // Construct the API endpoint URL
            let endpointUrl = "\(baseUrl)/tasks/\(updatedTask.id)"
            guard let url = URL(string: endpointUrl) else {
                completionHandler(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                return
            }
            
            // Create a PUT request for the endpoint
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Encode the updated task as JSON and add it to the request body
            
            print("😀 UPDATED TASK: \(updatedTask)")
            let jsonEncoder = JSONEncoder()
            jsonEncoder.dateEncodingStrategy = .formatted(dateFormatter)
            
            guard let jsonData = try? jsonEncoder.encode(updatedTask) else {
                completionHandler(nil, NSError(domain: "Failed to encode task", code: 0, userInfo: nil))
                return
            }
        
            request.httpBody = jsonData
            
            // Send the request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                // Handle errors
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                
                // Parse the response data into a Task object
                if let data = data {
                   completionHandler(true,nil)
                }
            }
            task.resume()
        }

    
}
