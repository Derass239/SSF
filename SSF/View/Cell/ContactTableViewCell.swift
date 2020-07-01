//
//  ContactTableViewCell.swift
//  SSF
//
//  Created by Valentin Limagne on 23/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContactTableViewCell: UITableViewCell, Bindable {
    
    // MARK: - Public attributes (IBOutlet)
    
    @ IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Public attributes (Bindable)
       
    var viewModel: ContactTableViewCellViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Public functions (Bindable)
    
    func bindViewModel() {
        setupTitleLabel()
    }
    
     // MARK: - Private functions
    
    fileprivate func setupTitleLabel() {
        
        viewModel.title.subscribe(onNext: { title in
            if title.contains("Numéro Vert National") {
                self.titleLabel.textColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
            }
            
            self.titleLabel.text = title
        }).disposed(by: disposeBag)
        
       
        
    }
}
