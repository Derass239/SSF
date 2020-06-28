//
//  ContactViewController.swift
//  SSF
//
//  Created by Valentin Limagne on 19/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ContactViewController: UIViewController, Bindable {
    
    // MARK: - Public attributes (IBOutlet)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Public attributes (Bindable)
    
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel: ContactViewControllerViewModel!
    
    // MARK: - Publiv functions (ViewController)
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ContactViewControllerViewModel()
        
        setupTableView()
        
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refresh()
    }
    
    func refresh() {
        viewModel.refresh()
    }
    
    // MARK: - Publiv functions (Bindable)
    
    func bindViewModel() {
        
        setupSearchTextField()
        setupTableViewDataHandling()
        refresh()
    }
    
    // MARK: - Private functions
        
    fileprivate func setupTableView() {
        
        tableView.register(UINib(resource: R.nib.contactTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.contactTableViewCell.identifier)
        
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = 45
    }
    
    
    fileprivate func setupTableViewDataHandling() {
        viewModel.reloadData.subscribe(onNext: {[weak self] (_) in
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
    
    fileprivate func setupSearchTextField() {
        searchTextField.rx.controlEvent([.editingChanged])
            .subscribe(onNext: {[weak self] (_) in
                guard let safeSelf = self else { return }
                
                safeSelf.viewModel.searchTerm.accept(safeSelf.searchTextField.text)
            })
        .disposed(by: disposeBag)
    }
}


extension ContactViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModelCell = viewModel.itemsCellsViewModels[indexPath.row]
        
        guard let cells = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        cells.bindViewModel(to: viewModelCell)
        
        return cells
    }
}

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contactDetailVC =  R.storyboard.main().instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        contactDetailVC.modalPresentationStyle = .fullScreen
        
       // contactDetailVC.viewModel.updateWith(ssf: SsfService.shared.ssfList[indexPath.row])

        self.present(contactDetailVC, animated: true)
    }
}
