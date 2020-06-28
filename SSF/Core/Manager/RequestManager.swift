//
//  RequestManager.swift
//  SSF
//
//  Created by Valentin Limagne on 19/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation
import Alamofire
import Reachability
import RxSwift
import RxCocoa

class RequestManager {
    
    // MARK: - Public attributes
    
    static let shared = RequestManager()
    
    // MARK: - Public functions
    
    func request(endpoint: String) -> DataRequest {
        return AF.request("https://ssfalert.fr/\(endpoint)", method: .get)
    }
}
