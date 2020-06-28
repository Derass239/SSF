//
//  ContactDetailViewController.swift
//  SSF
//
//  Created by Valentin Limagne on 26/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class ContactDetailViewControllerViewModel {
    
    // MARK: - Public attributes
    
    var itemsCellsViewModels: [ContactTableViewCellViewModel] = []
    var numberOfItems: Int {
        return itemsCellsViewModels.count
    }
    
    // MARK: - Private attributes
    
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    fileprivate var item: Ssf?
    
    // MARK: - Public functions
    
    func refresh() {
        //reloadData.onNext(())
    }
    
    func updateWith(ssf: Ssf) {
        self.item = ssf
        
        
    }
    
    init() {
        setupTableView()
    }
    
    
    fileprivate func setupTableView() {
        guard let safeCtdsList = item?.ctds else { return }
        
        self.itemsCellsViewModels = safeCtdsList.map({ (item) ->
         ContactTableViewCellViewModel in
            guard let safeCtds = item else { fatalError() }
            
            let viewModel = ContactTableViewCellViewModel()
            viewModel.updateWith(ctds: safeCtds)
            
            return viewModel
        })
    }
    
}
