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
    var shop: String?
    
    // Shop details
    struct ShopInfo {
        let title: String
        let address: String
        let contact: String
        let openingHours: String
    }
    
    // Dictionary to store shop details
    var shopDetails: [String: ShopInfo] = [:]
    
    // Zoom buttons
    let zoomInButton = UIButton(type: .system)
    let zoomOutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()        // Place map below navigation bar
        setupShopLocations()   // Set up shops with details
        setupZoomButtons()     // Add zoom buttons to the view
        checkLocationServices()
        
        // Set title for the navigation bar (optional)
        self.title = "Our Shops"
    }

    // Set up the map view below the navigation bar
    func setupMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        self.view.addSubview(mapView)
        
        // Add constraints to place the map view below the navigation bar
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), // Start below the navigation bar
            mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor) // Fill remaining space
        ])

        // Set initial region to Bangkok, Thailand
        let bangkokLocation = CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018) // Bangkok
        let region = MKCoordinateRegion(center: bangkokLocation, latitudinalMeters: 20000, longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
    }

    // Check if Location Services are enabled
    func checkLocationServices() {
//        if CLLocationManager.locationServicesEnabled() {
//            setupLocationManager()
//            checkLocationAuthorization()
//        } else {
//            // Notify the user to enable location services
//        }
        setupLocationManager()
        checkLocationAuthorization()
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

    // Set up annotations for shop locations in Bangkok and Samut Prakan with additional info
    func setupShopLocations() {
        // Shop 1 - Central Bangkok
        let shopLocation1 = CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018) // Central Bangkok
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = shopLocation1
        annotation1.title = "Shop 1 - Central Bangkok"
        
        shopDetails["Shop 1 - Central Bangkok"] = ShopInfo(
            title: "Shop 1 - Central Bangkok",
            address: "123 Sukhumvit Road, Bangkok",
            contact: "+66 1234 5678",
            openingHours: "9:00 AM - 6:00 PM"
        )

        // Shop 2 - Samut Prakan Area
        let shopLocation2 = CLLocationCoordinate2D(latitude: 13.5995, longitude: 100.5968) // Samut Prakan Area
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = shopLocation2
        annotation2.title = "Shop 2 - Samut Prakan"
        
        shopDetails["Shop 2 - Samut Prakan"] = ShopInfo(
            title: "Shop 2 - Samut Prakan",
            address: "456 Rama IX Road, Samut Prakan",
            contact: "+66 2345 6789",
            openingHours: "8:00 AM - 8:00 PM"
        )

        // Shop 3 - Ekkamai Area
        let shopLocation3 = CLLocationCoordinate2D(latitude: 13.7226, longitude: 100.5260) // Ekkamai Area
        let annotation3 = MKPointAnnotation()
        annotation3.coordinate = shopLocation3
        annotation3.title = "Shop 3 - Ekkamai"
        
        shopDetails["Shop 3 - Ekkamai"] = ShopInfo(
            title: "Shop 3 - Ekkamai",
            address: "789 Ekkamai Road, Bangkok",
            contact: "+66 3456 7890",
            openingHours: "10:00 AM - 7:00 PM"
        )

        // Add the annotations to the map view
        mapView.addAnnotations([annotation1, annotation2, annotation3])
    }

    // Customizing the annotation view to show the info button
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "ShopLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // Add info button to the callout
            let infoButton = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = infoButton
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    // Handle the tap on the info button in the callout
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotationTitle = view.annotation?.title ?? "" else { return }

        // Fetch the shop information
        if let shopInfo = shopDetails[annotationTitle] {
            let message = """
            Address: \(shopInfo.address)
            Contact: \(shopInfo.contact)
            Opening Hours: \(shopInfo.openingHours)
            """
            
            // Display the information in an alert
            let alert = UIAlertController(title: shopInfo.title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }

    // Set up zoom in and zoom out buttons
    func setupZoomButtons() {
        // Style the buttons with a background color, rounded corners, and shadow
        let buttonSize: CGFloat = 50
        let cornerRadius: CGFloat = buttonSize / 2
        
        // Set up zoom in button with symbol and style
        zoomInButton.setImage(UIImage(systemName: "plus.magnifyingglass"), for: .normal)
        zoomInButton.tintColor = .white
        zoomInButton.backgroundColor = .black
        zoomInButton.layer.cornerRadius = cornerRadius
        zoomInButton.layer.shadowColor = UIColor.black.cgColor
        zoomInButton.layer.shadowOpacity = 0.3
        zoomInButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        zoomInButton.layer.shadowRadius = 4
        zoomInButton.translatesAutoresizingMaskIntoConstraints = false
        zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        self.view.addSubview(zoomInButton)

        // Set up zoom out button with symbol and style
        zoomOutButton.setImage(UIImage(systemName: "minus.magnifyingglass"), for: .normal)
        zoomOutButton.tintColor = .white
        zoomOutButton.backgroundColor = .black
        zoomOutButton.layer.cornerRadius = cornerRadius
        zoomOutButton.layer.shadowColor = UIColor.black.cgColor
        zoomOutButton.layer.shadowOpacity = 0.3
        zoomOutButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        zoomOutButton.layer.shadowRadius = 4
        zoomOutButton.translatesAutoresizingMaskIntoConstraints = false
        zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        self.view.addSubview(zoomOutButton)
        
        // Position the buttons above the tab bar
        NSLayoutConstraint.activate([
            zoomInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            zoomInButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            zoomInButton.widthAnchor.constraint(equalToConstant: buttonSize),
            zoomInButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            zoomOutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            zoomOutButton.bottomAnchor.constraint(equalTo: zoomInButton.topAnchor, constant: -20),
            zoomOutButton.widthAnchor.constraint(equalToConstant: buttonSize),
            zoomOutButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }

    // Zoom in action
    @objc func zoomIn() {
        var region = mapView.region
        region.span.latitudeDelta /= 2.0
        region.span.longitudeDelta /= 2.0
        UIView.animate(withDuration: 0.5) {
            self.mapView.setRegion(region, animated: true)
        }
    }

    // Zoom out action
    @objc func zoomOut() {
        var region = mapView.region
        region.span.latitudeDelta *= 2.0
        region.span.longitudeDelta *= 2.0
        UIView.animate(withDuration: 0.5) {
            self.mapView.setRegion(region, animated: true)
        }
    }
}

