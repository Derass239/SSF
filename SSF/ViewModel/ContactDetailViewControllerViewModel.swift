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
     
    var title: BehaviorRelay<String> = BehaviorRelay(value: "")
    let reloadData: PublishSubject<Void> = PublishSubject()
    var itemsCellsViewModels: [ContactTableViewCellViewModel] = []
    var numberOfItems: Int {
        return itemsCellsViewModels.count
    }
    
    // MARK: - Private attributes
    
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    fileprivate var item: Ssf?
    
    // MARK: - Public functions
    
    init() { }
    
    func updateWith(ssf: Ssf) {
        self.item = ssf
        setupTitle()
        setupTableView()
    }
    
    fileprivate func setupTitle() {
        title.accept(item!.name)
    }
    
    // MARK: - Private functions
    
    fileprivate func setupTableView() {
        guard var safeCtdsList = item?.ctds else { return }
        safeCtdsList.append(Ctds(name: "Numéro Vert National", phonePerso: "+33 0800 121 123", phoneWork: "", phoneMobile: ""))
        
        self.itemsCellsViewModels = safeCtdsList.map({ (item) ->
         ContactTableViewCellViewModel in
            guard let safeCtds = item else { fatalError() }
            
            let viewModel = ContactTableViewCellViewModel()
            viewModel.updateWith(ctds: safeCtds)
            
            return viewModel
        })
    }
    
}
