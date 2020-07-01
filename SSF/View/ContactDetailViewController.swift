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

class ContactDetailViewController: UIViewController {
    
    // MARK: - Public attributes (IBOutlet)
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var titleNavBar: UINavigationItem!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    // MARK: - Public attributes (Bindable)
    
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel: ContactDetailViewControllerViewModel!
    var ssf: Ssf?
    
    // MARK: - Public functions (ViewController)
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ContactDetailViewControllerViewModel()
        guard let safeSsf = ssf else { return }
        
        viewModel.updateWith(ssf: safeSsf)
        
        setupTableView()
        setupTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.detailTableView.contentSize.height
    }
    
    // MARK: - Private functions
    
    fileprivate func setupTitle() {
        viewModel.title.asObservable()
            .bind(to: titleNavBar.rx.title)
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupTableView() {
        detailTableView.register(UINib(resource: R.nib.contactTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.contactTableViewCell.identifier)
        
        detailTableView.tableFooterView = UIView()
        detailTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        detailTableView.estimatedRowHeight = 45
        detailTableView.rowHeight = 45
    }
    
}

    // MARK: - TableViewDataSource

extension ContactDetailViewController: UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}

    // MARK: - TableViewDelegate

extension ContactDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let safeCtds = viewModel.itemsCellsViewModels[indexPath.row].ctds else { return }
        
        let alert = UIAlertController(title: "Contactez", message: "", preferredStyle: .alert)
        
        if (!safeCtds.phoneMobile.isEmpty) {
            let action = UIAlertAction(title: safeCtds.phoneMobile, style: .default, handler: nil)
            let img = UIImage(systemName: "phone")
            action.setValue(img, forKey: "image")
            alert.addAction(action)
        }
        if (!safeCtds.phonePerso.isEmpty) {
            let action = UIAlertAction(title: safeCtds.phonePerso, style: .default, handler: nil)
            let img = UIImage(systemName: "house")
            action.setValue(img, forKey: "image")
            alert.addAction(action)
        }
        if (!safeCtds.phoneWork.isEmpty) {
            let action = UIAlertAction(title: safeCtds.phoneWork, style: .default, handler: nil)
            let img = UIImage(systemName: "tray.2")
            action.setValue(img, forKey: "image")
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
        
        print(viewModel.itemsCellsViewModels[indexPath.row].ctds)
    }
}

