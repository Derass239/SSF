//
//  ContactTableViewCellViewModel.swift
//  SSF
//
//  Created by Valentin Limagne on 24/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContactTableViewCellViewModel {
    
    // MARK: - Public attributes
    
    var ssf: Ssf?
    var ctds: Ctds?
    
    var title: BehaviorRelay<String> = BehaviorRelay(value: "-")
    
    // MARK: - Private attributes
    
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Public functions
    
    init() { }
    
    func updateWith(ssf: Ssf) {
        self.ssf = ssf
        
        self.title.accept("\(ssf.id) - \(ssf.name)")
    }
    
    func updateWith(ctds: Ctds) {
        self.ctds = ctds
        
        self.title.accept(ctds.name)
    }
}
