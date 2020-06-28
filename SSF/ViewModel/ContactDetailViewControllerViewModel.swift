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
    fileprivate var item: [Ssf] = []
    
    // MARK: - Public functions
    
    func refresh() {
        //reloadData.onNext(())
    }
    
    init() {
        //setupTableView()
        //setupSearchTerm()
    }
    
    
}
