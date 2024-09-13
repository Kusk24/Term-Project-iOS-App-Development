//
//  OurShopPage.swift
//  Term Project
//
//  Created by Win Yu Maung on 03/09/2024.
//

import UIKit
import MapKit
import CoreLocation

class OurShopPage: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupShopLocations()
        checkLocationServices()
    }

    // Set up the map view
    func setupMapView() {
        mapView = MKMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.showsUserLocation = true
        self.view.addSubview(mapView)

        // Set initial region to Bangkok, Thailand
        let bangkokLocation = CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018) // Bangkok
        let region = MKCoordinateRegion(center: bangkokLocation, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
    }

    // Check if Location Services are enabled
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Notify the user to enable location services
        }
    }

    // Set up Location Manager
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // Check Location Authorization
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
        case .denied, .restricted:
            // Show alert to inform user how to enable location services
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    // Set up annotations for shop locations in Bangkok and Samut Prakan
    func setupShopLocations() {
        // Example shop locations in Bangkok and Samut Prakan (use real or imaginary locations)
        let shopLocation1 = CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018) // Example: Central Bangkok
        let shopLocation2 = CLLocationCoordinate2D(latitude: 13.5995, longitude: 100.5968) // Example: Samut Prakan Area
        let shopLocation3 = CLLocationCoordinate2D(latitude: 13.7226, longitude: 100.5260) // Example: Ekkamai Area
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = shopLocation1
        annotation1.title = "Shop 1 - Central Bangkok"

        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = shopLocation2
        annotation2.title = "Shop 2 - Samut Prakan"

        let annotation3 = MKPointAnnotation()
        annotation3.coordinate = shopLocation3
        annotation3.title = "Shop 3 - Ekkamai"

        // Add the annotations to the map view
        mapView.addAnnotations([annotation1, annotation2, annotation3])
    }

    // Customizing the annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "ShopLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}
