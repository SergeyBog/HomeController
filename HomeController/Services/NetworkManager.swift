//
//  NetworkManager.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import Foundation

class NetworkManager {
    
    typealias DeviceResponse = ([Device]?, Error?) -> Void

    func getDevicesFromServer(completion:@escaping DeviceResponse) {
        
        let decoder = JSONDecoder()
        
        guard let url = URL(string:"http://storage42.com/modulotest/data.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, resonse, error in
            if error != nil {
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let response = try decoder.decode(Response.self, from: data)
                completion(response.devices, nil)
            } catch {
                completion(nil, error)
            }

        }.resume()
    }
    
}
