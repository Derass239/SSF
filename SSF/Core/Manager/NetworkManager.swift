//
//  NetworkManager.swift
//  SSF
//
//  Created by Valentin Limagne on 21/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
