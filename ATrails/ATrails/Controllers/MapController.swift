//
//  MapController.swift
//  ATrails
//
//  Created by Turing on 11/12/23.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

class MapStruct: UIViewRepresentable, ObservableObject {
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // Set initial location coordinates
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000) // Define the region to display

        uiView.setRegion(region, animated: true) // Set the region to display on the map
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
}
