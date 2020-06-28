//
//  LaunchViewController.swift
//  SSF
//
//  Created by Valentin Limagne on 22/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LaunchViewController: UIViewController {
    
    // MARK: - Public attributes (IBOutlet)
    
    
    // MARK: - Public attributes (Bindable)
    
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel: LaunchViewControllerViewModel!
    
    
    
    // MARK: - Public functions (ViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LaunchViewControllerViewModel()
        
        setupSwitchToHome()
        
        viewModel.getSsfList()
    }
    
    // MARK: - Private functions
    
    fileprivate func setupSwitchToHome() {
        viewModel.next.asObserver()
            .subscribe(onNext: {[weak self] () in
                guard let safeSelf = self else { return }
                
                let homeVC = R.storyboard.main().instantiateViewController(identifier: "TabBarController")
                if #available(iOS 13, *) {
                    homeVC.modalPresentationStyle = .fullScreen
                }
                safeSelf.present(homeVC, animated: true, completion: nil)
            })
        .disposed(by: disposeBag)
    }
}
