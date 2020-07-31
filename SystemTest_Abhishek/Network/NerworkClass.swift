//
//  NerworkClass.swift
//  AbhishekMachineTest-1Kosmos
//
//  Created by Abhishek Nagar on 05/07/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//
import UIKit
import Foundation
import SwiftyJSON
struct Constant {
    
    static var offset = "1"
    static var api = "https://api.cognitive.microsoft.com/bing/v7.0/images/search?q=cats&count=20&offset=" + offset + "&mkt=en-us&safeSearch=Moderate"
    static var OcpApiumKey = "044bf9281c7d4b52818ac850d2d0ab28"

    static let inetervalForRequest = 20.0
    static let inetervalForResource = 40.0
}
final class Service: NSObject {
    static let shared = Service()
    
    func getServerData(_ offset: String, completion: @escaping (_ mainModel: MainDataModel?, _ error: Error?) -> Void) {
        
        Constant.offset = offset
        guard let serviceUrl = URL(string: Constant.api) else {
            return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = ["Ocp-Apim-Subscription-Key":Constant.OcpApiumKey]
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Constant.inetervalForRequest
        sessionConfig.timeoutIntervalForResource = Constant.inetervalForResource
        let session = URLSession(configuration: sessionConfig)
        DispatchQueue.main.async { Helper.shared.activityStartAnimating()}
        
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { Helper.shared.activityStopAnimating()}
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
                    let mainModel = try? decoder.decode(MainDataModel.self, from: utf8Data!)
                    completion(mainModel, nil)
                } else {
                    completion(nil, error)
                }
            } else if error != nil {
                completion(nil, error)
            }
            
        }.resume()
    }
}
