//
//  TaskModel.swift
//  bucketlist
//
//  Created by Omar Ihmoda on 1/23/18.
//  Copyright © 2018 Omar Ihmoda. All rights reserved.
//


import Foundation
class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://127.0.0.1:4200/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
}
