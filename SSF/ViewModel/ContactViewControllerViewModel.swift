//
//  ContactViewControllerViewModel.swift
//  SSF
//
//  Created by Valentin Limagne on 19/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class ContactViewControllerViewModel {
    
    // MARK: - Public attributes
    
    let searchTerm = BehaviorRelay<String?>(value: "")
    let reloadData: PublishSubject<Void> = PublishSubject()
    var itemsCellsViewModels: [ContactTableViewCellViewModel] = []
    var numberOfItems: Int {
        return itemsCellsViewModels.count
    }
    
    // MARK: - Private attributes
    
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    fileprivate var item: [Ssf] = []
    
    // MARK: - Public functions
    
    func refresh() {
        reloadData.onNext(())
    }
    
    init() {
        setupTableView()
        setupSearchTerm()
    }
    
    // MARK: - Private functions
    
    fileprivate func setupTableView() {
        item = SsfService.shared.ssfList
        
        setData(ssfList: item)
        
        reloadData.onNext(())
    }
    
    fileprivate func setupSearchTerm() {
        searchTerm.asObservable()
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (_) in
                guard let safeSelf = self,
                    let safeSearchTerm = self!.searchTerm.value else { return }
                
                var ssfList: [Ssf] = []
                
                if (safeSearchTerm.count >= 1) {
                    ssfList = safeSelf.item.filter { $0.name.lowercased().contains(safeSearchTerm.lowercased()) ||
                        $0.id.lowercased().contains(safeSearchTerm.lowercased())
                    }
                } else {
                    ssfList = safeSelf.item
                }
                
                safeSelf.setData(ssfList: ssfList)
                
                safeSelf.reloadData.onNext(())
            })
        .disposed(by: disposeBag)
    }
    
    fileprivate func setData(ssfList: [Ssf]) {
        self.itemsCellsViewModels = ssfList.map({ (item) -> ContactTableViewCellViewModel in
            
            let viewModel = ContactTableViewCellViewModel()
            viewModel.updateWith(ssf: item)
            
            return viewModel
        })
    }
}
