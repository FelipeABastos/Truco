//
//  Request.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import Foundation

class Request {
    let session = URLSession.shared
    let request = NSMutableURLRequest()
    
    func request<T:Decodable>(method: RequestType, endpoint: String, parameters: Dictionary<String, Any>, responseType: T.Type, completion: @escaping (_ response: Any?, _ code: Int) -> Void) {
        
        let baseURL = "https://deckofcardsapi.com/api/deck/"
        
        var serverURL:String = baseURL + endpoint
        
        switch method {
        case .get:
            serverURL += parameters.buildQueryString()
            request.httpMethod = "GET"
            print(serverURL)
            break
        default:
            break
        }
        
        request.url = URL(string: serverURL)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            let responseCode = response?.getStatusCode() ?? 0
            
            if error != nil {
                print(error.debugDescription )
                return
            }
            
            do {
                let json = try JSONDecoder().decode(responseType, from: data!)
                print(json)
                
                DispatchQueue.main.async {
                    completion(json, responseCode)
                }
            } catch {
                print("Error during JSON serialization: \(error)")
                DispatchQueue.main.async {
                    completion(false, responseCode)
                }
            }
            
        })
        task.resume()
    }
}

