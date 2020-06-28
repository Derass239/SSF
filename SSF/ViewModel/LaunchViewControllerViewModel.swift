//
//  LaunchViewControllerViewModel.swift
//  SSF
//
//  Created by Valentin Limagne on 22/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LaunchViewControllerViewModel {
    
    // MARK: - Public attributes
    
    var next = PublishSubject<Void>()
    
    // MARK: - Private attributes
    
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    fileprivate var ssfService: SsfService
    
    // MARK: - Public functions
    
    init(ssfService: SsfService = SsfService()) {
        self.ssfService = ssfService
    }
    
    func getSsfList() {
        ssfService.loadData().subscribe(onNext: {[weak self] ssfList in
            guard let safeSelf = self else { return }

            SsfService.shared.ssfList = ssfList
            
            safeSelf.next.onNext(())
        })
        .disposed(by: disposeBag)
    }
}
