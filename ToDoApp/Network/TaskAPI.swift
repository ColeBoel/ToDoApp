//
//  TaskAPI.swift
//  ToDoApp
//
//  Created by Joshua Boelman on 3/2/23.
//

import Foundation

class TaskAPI {
    
    static let baseUrl = "http://localhost:3000"
    
    static func fetchTasks(completed: Bool?, sortBy: String?, completionHandler: @escaping ([Task]?, Error?) -> Void) {

        // Construct the API endpoint URL with query parameters
        var endpointUrl = "\(baseUrl)/tasks"
        
        if let completed = completed {
            endpointUrl += "?completed=\(completed)"
        }
        if let sortBy = sortBy {
            endpointUrl += "&sort_by=\(sortBy)"
        }
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
                    
                    let tasks = try JSONDecoder().decode(Tasks.self, from: data)
                    print("Data: \(tasks)")
                    completionHandler(tasks.tasks, nil)
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
}
