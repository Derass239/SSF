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
    
    // MARK: - Public attributes (Bindable)
    
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel: ContactDetailViewControllerViewModel!
 
    // MARK: - Public functions (ViewController)
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ContactDetailViewControllerViewModel()
        
        //setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refresh()
    }
    
    func refresh() {
        viewModel.refresh()
    }
    
    // MARK: - Private functions
        
    fileprivate func setupTableView() {
        detailTableView.register(UINib(resource: R.nib.contactTableViewCell), forCellReuseIdentifier: R.reuseIdentifier.contactTableViewCell.identifier)
        
        detailTableView.tableFooterView = UIView()
        detailTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        detailTableView.estimatedRowHeight = 45
        detailTableView.rowHeight = 45
    }
}

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
}
