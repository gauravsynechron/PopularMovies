//
//  Network.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import Foundation

final class Network: NSObject {
    
    static let sharedInstance = Network()
    private override init() {}
    
    private func getAccessToken() -> String {
        return "Bearer \(Constant.authToken)"
    }
    
    func getData(page:Int, completionHandler: @escaping (Bool, ResponseData?, String?) -> Void ) {
        guard let url = URL(string: "\(MovieURL.popularMovieUrl)\(page)") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(self.getAccessToken(), forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if error == nil && data != nil {
                do {
                    let result = try JSONDecoder().decode(ResponseData.self, from: data!)
                    completionHandler(true, result, nil)
                } catch let error {
                    debugPrint(error)
                    completionHandler(false, nil, "Parsing Error")
                }
            } else {
                completionHandler(false, nil, "Something went wrong")
            }
            
        }.resume()

    }
}
