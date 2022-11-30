//
//  Networking.swift
//  Contact
//
//  Created by MacBookAir on 26/11/22.
//

import UIKit

public enum Result<T> {
    case success(T)
    case failure(Error)
}

final class Networking: NSObject {
    
    private static func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public static func downloadImage(url: URL, completion: @escaping (Result<Data>) -> Void) {
        Networking.getData(url: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
    
    public static func makeHTTPRequest(
        completion: @escaping ([Contact])->(),
        serverURL: String = "https://contactsapi20221123195736.azurewebsites.net",
        baseURL: String = "/api/v1/Contacts",
        endpoint: String = "",
        parameters: [String : Any] = [:],
        method: String = "GET",
        headers: [String : String] = [:]
    ) {
        let apiURL = serverURL + baseURL + endpoint
        
        let url = URL(string: apiURL)
        
        var request = URLRequest(url: url!)

        request.httpMethod = method
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if !parameters.isEmpty && method == "POST" {
            
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
            request.setValue(String(jsonData!.count), forHTTPHeaderField: "Content-Length")
            
            request.httpBody = jsonData
        }
        
        guard url != nil else {
            print("error")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil, data != nil {
                if method == "GET" {
                    do {
                        
                        let decoder = JSONDecoder()
                        let ParsingData = try decoder.decode([Contact].self, from: data!)
                        completion(ParsingData)
                        
                    } catch {
                        print("Error parseando Json!")
                    }
                }
            }
            
        }.resume()
    }

}
