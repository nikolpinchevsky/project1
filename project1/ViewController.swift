//
//  ViewController.swift
//  project1
//
//  Created by Sean on 31/05/2026.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!

    let locationManager = CLLocationManager()
    let middleLongitude = 34.817549168324334
    var userSide = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }

        let longitude = location.coordinate.longitude

        if longitude > middleLongitude {
            userSide = "East Side"
        } else {
            userSide = "West Side"
        }

        print("Longitude: \(longitude)")
        print("Side: \(userSide)")

        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        
        if name.isEmpty {
            return
        }
        
        hiLabel.text = "Hi \(name)"
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.performSegue(withIdentifier: "showGame", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameVC = segue.destination as? GameViewController {
            gameVC.playerName = nameTextField.text ?? "Player"
        }
    }
}
