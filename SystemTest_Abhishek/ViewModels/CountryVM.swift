//
//  CountryVM.swift
//  InfosysExercise_Abhi
//
//  Created by Abhishek Nagar on 06/07/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import SwiftyJSON

final class CountryVM {
    init() {
        
    }
    var dataTitle: String?
    var totalEstimatedMatches, nextOffset, currentOffset: Int?
    var dataValues: [Value] = []
    
    var itemCount: Int {
        return self.dataValues.count
    }
    func item(_ indexPath: IndexPath) -> Value {
        return self.dataValues[indexPath.row]
    }
    
    //fetch country data
    @objc func getServerData(offset: String, completion: @escaping (_ error: Error?) -> Void) {
        Service.shared.getServerData(offset) { [weak self](mainModel, error) in
            if let error = error {
                completion(error)
            } else {
                self?.dataTitle = mainModel?.type
                self?.totalEstimatedMatches = mainModel?.totalEstimatedMatches
                self?.nextOffset = mainModel?.nextOffset
                if let items = mainModel?.value {
                    self?.dataValues.append(contentsOf: items)
                }
                completion(nil)
            }
        }
    }
    
    func loadMoreData(offset: Int, completion: @escaping() -> Void){
        getServerData(offset: "\(offset)", completion: {_ in completion()})
    }
}
