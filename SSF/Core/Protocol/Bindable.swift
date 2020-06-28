//
//  Bindable.swift
//  SSF
//
//  Created by Valentin Limagne on 22/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift

protocol Bindable: class {
    
    associatedtype ViewModelType
    
    // MARK: - Protocol attributes
    
    var viewModel: ViewModelType! { get set }
    var disposeBag: DisposeBag { get set }
    
    // MARK: - Protocol functions
    
    func bindViewModel()
    
}

extension Bindable {
    
    // MARK: - Default functions implementation
    
    func bindViewModel(to viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        // Clean all observable
        disposeBag = DisposeBag()
        
        bindViewModel()
    }
    
}

extension Bindable where Self: UIViewController {
    
    // MARK: - Default functions implementation for UIViewController
    
    func bindViewModel(to viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        loadViewIfNeeded()
        
        // Clean all observable
        disposeBag = DisposeBag()
        
        bindViewModel()
    }
    
}
