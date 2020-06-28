//
//  HomeViewController.swift
//  SSF
//
//  Created by Valentin Limagne on 19/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftLocation
import MapKit

class HomeViewController: UIViewController, Bindable {
    
    // MARK: - Public attributes (IBOutlet)
    
    
    // MARK: - Public attributes (Bindable)
    
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel: HomeViewControllerViewModel!
    
    // MARK: - Publiv functions (ViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewControllerViewModel()
        
        let request = LocationManager.shared.locateFromGPS(.continous, accuracy: .city) { data in
          switch data {
            case .failure(let error):
              print("Location error: \(error)")
            case .success(let location):
                print("New Location: \(location)")
            
                let location = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                location.fetchZip { zip, error in
                    guard let zip = zip, error == nil else { return }
                    print(zip)  // Rio de Janeiro, Brazil
                }
            
          }
        }
        request.dataFrequency = .fixed(minInterval: 40, minDistance: 100)
        
    }
    
    // MARK: - Publiv functions (Bindable)
    
    func bindViewModel() {
        
    }
    
    
    // MARK: - Private functions
}


