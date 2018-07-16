//
//  DataService.swift
//  20180713-VA-NYCSchools
//
//  Created by Victor  Adu on 7/13/18.
//  Copyright © 2018 Filmic. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func highSchoolsLoaded()
    func highSchoolsAvgSATScoresLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var highSchools = [HighSchoolInfo]()
    var schoolSATStats = [SchoolStats]()
    
    // GET all NYC high schools
    func getAllNYCHighSchools() {
        let sessionConfig = URLSessionConfiguration.default
        
        // Create session, and optionally set a URLSessionDelegate
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        // Create the request
        guard let URL = URL(string: BASE_NYCHIGHSCHOOLS_API_URL) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                if let data = data {
                    let results = try! JSONDecoder().decode([HighSchoolInfo].self, from: data)
                    self.highSchools = results
                    self.delegate?.highSchoolsLoaded()
                }
            }
            else {
                // Failure
                print("URL Session Task Failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    // GET NYC high schools SAT Scores
    func getAllNYCHighSchoolsAvgSATScores() {
        let sessionConfig = URLSessionConfiguration.default
        
        // Create session, and optionally set a URLSessionDelegate
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: BASE_NYCHIGHSCHOOLS_AVG_SAT_SCORES_API_URL) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                if let data = data {
//                    print("DATA:", data)
                    let results = try! JSONDecoder().decode([SchoolStats].self, from: data)
                    self.schoolSATStats = results
                    self.delegate?.highSchoolsAvgSATScoresLoaded()
                }
            }
            else {
                // Failure
                print("URL Session Task Failed: \(error!.localizedDescription)")
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}


