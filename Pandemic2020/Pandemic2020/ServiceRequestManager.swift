//
//  ServiceRequestManager.swift
//  Pandemic2020
//
//  Created by Shilpa S on 04/12/20.
//  Copyright © 2020 Shilpa S. All rights reserved.
//

import Foundation
import Alamofire

//MARK : The Class handles all the API request.
class ServiceRequestManager {
    
    static let shared = ServiceRequestManager()
    
    let baseURL : String = "https://api.covid19api.com"
    
    private init() {
        
    }
    func getCountries(onCompletion handler : @escaping (([Any]) -> ())) {
        let requestUrl = baseURL.appending("/countries")
        if let url = URL(string: requestUrl) {
            self.makeRequest(with: url, onCompletion: handler)
        }
        else {
            handler([])
        }
    }
    
    func getAllStatus(forCountry country : String, onCompletion handler : @escaping (([Any])->())) {
        let requestUrl = baseURL.appending("/total/country/" + country.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!)
        if let url = URL(string: requestUrl) {
            self.makeRequest(with: url, onCompletion: handler)
        }
        else {
            handler([])
        }
    }
    
    private func makeRequest(with url : URL, onCompletion handler : @escaping (([Any])->())) {
        
        do {
            let urlRequest = try URLRequest(url: url, method: .get)
            Alamofire.request(urlRequest).responseJSON(completionHandler: {
                response in
                if let responseData = response.data {
                    do {
                        if let responseJSON = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [Any] {
                            handler(responseJSON)
                        }
                        else {
                            handler([])
                        }
                    }
                    catch {
                        handler([])
                    }
                }
            })
        }
        catch {
            //Send emtpy response on error
            handler([])
        }
        

    }
    
}
