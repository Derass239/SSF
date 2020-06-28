//
//  SsfService.swift
//  SSF
//
//  Created by Valentin Limagne on 21/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyXMLParser

class SsfService {
    
    // MARK: - Public attributes
    
    public static let shared = SsfService()
    var ssfList: [Ssf] = []
    
    // MARK: - Public functions
    
    func loadData() -> Observable<[Ssf]> {
        return Observable.create { observer in
            var list: [Ssf] = []
            
            if NetworkManager.isConnected() {
                RequestManager.shared.request(endpoint: "depts.xml").responseData { response in
                    if let data = response.data {
                        let xml = XML.parse(data)
                        
                        for ssf in xml["departements", "ssf"] {
                            var ctList: [Ctds?] = []
                            
                            let id = ssf["id"].text
                            let name = ssf["nom"].text
                            
                            for ctds in ssf["les_ct", "ctds"] {
                                let ctName = ctds["nom_ct"].text
                                let phonePerso = ctds["perso"].text
                                let phoneWork = ctds["travail"].text
                                let phoneMobile = ctds["mobile"].text
                                
                                ctList.append(Ctds(name: ctName ?? "",
                                                   phonePerso: phonePerso ?? "",
                                                   phoneWork: phoneWork ?? "",
                                                   phoneMobile: phoneMobile ?? ""))
                            }
                            
                            list.append(Ssf(id: id!,
                                                    name: name!,
                                                    ctds: ctList))
                        }
                    }
                    
                    let ssfListData = try! JSONEncoder().encode(list)
                    UserDefaults.standard.set(ssfListData, forKey: "ssflist")
                    
                    observer.onNext(list)
                }
            } else {
                let ssfListData = UserDefaults.standard.data(forKey: "ssflist")
                list = try! JSONDecoder().decode([Ssf].self, from: ssfListData!)
                observer.onNext(list)
                
            }
            return Disposables.create()
        }
    }
    
}
