//
//  CLLocation+zip.swift
//  SSF
//
//  Created by Valentin Limagne on 25/06/2020.
//  Copyright © 2020 Valentin Limagne. All rights reserved.
//

import MapKit

extension CLLocation {
    func fetchZip(completion: @escaping (_ zip: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.postalCode, $1) }
    }
}
