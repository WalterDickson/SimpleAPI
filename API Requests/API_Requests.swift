//
//  API_Requests.swift
//  API Requests
//
//  Created by Asante on 8/10/20.
//  Copyright © 2020 Walter Dickson. All rights reserved.
//

import Foundation

struct SavedDataMore: Codable {
    static var SavedDataMore = [SavedData]()
}

final class SavedData: Codable {
    var id: Int?
    var sunrise: String?
    var sunset: String?
    var solar_noon: String?
    var day_length: Int?
    var astronomical_twilight_begin: String?
    var astronomical_twilight_end: String?
    var civil_twilight_begin: String?
    var civil_twilight_end: String?
    var nautical_twilight_begin: String?
    var nautical_twilight_end: String?
    
    
    init() {}
    
    init(id: Int?, sunrise: String?, sunset: String?, solar_noon: String?, day_length: Int?, astronomical_twilight_begin: String?, astronomical_twilight_end: String?, civil_twilight_begin: String?, civil_twilight_end: String?, nautical_twilight_begin: String?, nautical_twilight_end: String?) {
        self.id = id
        self.sunrise = sunrise
        self.sunset = sunset
        self.solar_noon = solar_noon
        self.day_length = day_length
        self.astronomical_twilight_begin = astronomical_twilight_begin
        self.astronomical_twilight_end = astronomical_twilight_end
        self.civil_twilight_begin = civil_twilight_begin
        self.civil_twilight_end = civil_twilight_end
        self.nautical_twilight_begin = nautical_twilight_begin
        self.nautical_twilight_end = nautical_twilight_end
    }
    
}

enum APIError: Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequests {
    let resourceURL: URL
    
    init(endpoint: String) {
        let resourceString = "\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
    }
    
    func save(_ savedData: SavedData, completion: @escaping(Result<SavedData, APIError>) -> Void) {
        
        do {
            var urlRequest = URLRequest(url: resourceURL)
            //urlRequest.httpMethod = "POST"
            //urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //urlRequest.addValue("Bearer ", forHTTPHeaderField: "Authorization")
            urlRequest.httpBody = try JSONEncoder().encode(savedData)
            let data = try JSONEncoder().encode(savedData)
            //print(String(data: data, encoding: .utf8)!)
            
            let task = URLSession.shared.dataTask(with: urlRequest) {data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                let responseString = String(data: jsonData, encoding: .utf8)
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    print(jsonResponse)
                    guard let jsonArray = jsonResponse as? [String: Any] else {
                        return
                    }
                    if (jsonArray.keys.contains("error")) {
                        print("Error")
                    } else {
                        print(jsonArray["id"] as! Int)
                        savedData.id = jsonArray["id"] as? Int
                        
                        let queue: OperationQueue = OperationQueue()
                        queue.maxConcurrentOperationCount = 1
                        print(responseString!)
                    }
                } catch {
                    print("error")
                }
                do {
                    let savedData = try JSONDecoder().decode(SavedData.self, from: jsonData)
                    print("Saved Data: \(savedData)")
                    completion(.success(savedData))
                } catch {
                    completion(.failure(.decodingProblem))
                }
            }
            task.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func load(completion: @escaping(Result<SavedData, APIError>) -> Void) {
        var urlRequest = URLRequest(url: resourceURL)
        urlRequest.httpMethod = "POST"
        //urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //urlRequest.addValue("Bearer ", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _,_ in
            guard let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            //let responseString = String(data: jsonData, encoding: .utf8)
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: [])
                //print(jsonResponse)
                guard let jsonArray = jsonResponse as? [String: Any] else {
                    return
                }
                if (jsonArray.keys.contains("error")) {  } else {
                    let array = jsonArray["results"] as? [String: AnyObject]
                    let s : SavedData = SavedData()
                    
                    for i in array! {
                        //print("i: \(i.key)")
                        
                        s.id = 5
                        switch i.key {
                        case "sunrise":
                            s.sunrise = i.value as? String
                        case "sunset":
                            s.sunset = i.value as? String
                        case "solar_noon":
                            s.solar_noon = i.value as? String
                        case "astronomical_twilight_begin":
                            s.astronomical_twilight_begin = i.value as? String
                        case "astronomical_twilight_end":
                            s.astronomical_twilight_end = i.value as? String
                        case "civil_twilight_begin":
                            s.civil_twilight_begin = i.value as? String
                        case "civil_twilight_end":
                            s.civil_twilight_end = i.value as? String
                        case "day_length":
                            s.day_length = i.value.intValue
                        case "nautical_twilight_begin":
                            s.nautical_twilight_begin = i.value as? String
                        case "nautical_twilight_end":
                            s.nautical_twilight_end = i.value as? String
                        default:
                            return
                        }
                    }
                    completion(.success(s))
                    let queue: OperationQueue = OperationQueue()
                    queue.maxConcurrentOperationCount = 1
                    //print("Response: \(responseString)")
                }
            } catch { print(error) }
        }
        task.resume()
    }
}
