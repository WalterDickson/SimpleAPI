//
//  ViewController.swift
//  API Requests
//
//  Created by Asante on 8/2/20.
//  Copyright © 2020 Walter Dickson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lat = "36.7201600"
    var long = "-4.4203400"
    var date = "2020-09-23"
    
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var dayLength: UILabel!
    @IBOutlet weak var solarNoon: UILabel!
    @IBOutlet weak var astroTwiBegin: UILabel!
    @IBOutlet weak var astroTwiEnd: UILabel!
    @IBOutlet weak var civTwiBegin: UILabel!
    @IBOutlet weak var civTwiEnd: UILabel!
    @IBOutlet weak var nautTwiBegin: UILabel!
    @IBOutlet weak var nautTwiEnd: UILabel!
    @IBOutlet weak var astroTwiliLbl: UILabel!
    @IBOutlet weak var civiTwiliLbl: UILabel!
    @IBOutlet weak var nautiTwiliLbl: UILabel!
    @IBOutlet weak var latLbl: UILabel!
    @IBOutlet weak var longLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentPostLbl: UILabel!
    @IBOutlet weak var latTextField: UITextField!
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var requestButton: UIButton!
    
    func dateFormat(timeResult: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:timeResult)!
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "h:mm a"
        return convertDateFormatter.string(from: date)
    }
    
    let style = Style.iPhone
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apply()
        //dateFormat(timeResult: "2020-08-11T05:32:31+00:00")
        loadData()
    }
    
    @IBAction func textEditEnded(_ sender: UITextField) {
        lat = latTextField.text!
        long = longTextField.text!
        print("lat: \(lat) \nlong: \(long)")
    }
    
    
    @IBAction func sendRequest(_ sender: UIButton) {
        
    }
    
    func loadData() {
        let url = "https://api.sunrise-sunset.org/json?lat=\(lat)&lng=\(long)&date=\(date)&formatted=0"
        let postRequest = APIRequests(endpoint: "\(url)")
        
        print(postRequest)
        postRequest.load(completion: { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let i):
                print("Success")
                print("Sunrise: \(self?.dateFormat(timeResult: i.sunrise!) ?? "")")
                print("Sunset: \(self?.dateFormat(timeResult: i.sunset!) ?? "")")
                print("Day Length: \(i.day_length ?? Int())")
                print("Solar Noon: \(self?.dateFormat(timeResult: i.solar_noon!) ?? "")")
                print("Astronomical Twilight Begin: \(self?.dateFormat(timeResult: i.astronomical_twilight_begin!) ?? "")")
                print("Astronomical Twilight End: \(self?.dateFormat(timeResult: i.astronomical_twilight_end!) ?? "")")
                print("Civil Twilight Begin: \(self?.dateFormat(timeResult: i.civil_twilight_begin!) ?? "")")
                print("Civil Twilight End: \(self?.dateFormat(timeResult: i.civil_twilight_end!) ?? "")")
                print("Nautical Twilight Begin: \(self?.dateFormat(timeResult: i.nautical_twilight_begin!) ?? "")")
                print("Nautical Twilight End: \(self?.dateFormat(timeResult: i.nautical_twilight_end!) ?? "")")
                DispatchQueue.main.async {
                    self?.sunrise.text = "Sunrise: \n\(self?.dateFormat(timeResult: i.sunrise!) ?? "")"
                    self?.sunset.text = "Sunset: \n\(self?.dateFormat(timeResult: i.sunset!) ?? "")"
                    self?.dayLength.text = "Day Length: \n\(i.day_length ?? Int())"
                    self?.solarNoon.text = "Solar Noon: \n\(self?.dateFormat(timeResult: i.solar_noon!) ?? "")"
                    self?.astroTwiBegin.text = "Begins: \n\(self?.dateFormat(timeResult: i.astronomical_twilight_begin!) ?? "")"
                    self?.astroTwiEnd.text = "End: \n\(self?.dateFormat(timeResult: i.astronomical_twilight_end!) ?? "")"
                    self?.civTwiBegin.text = "Begins: \n\(self?.dateFormat(timeResult: i.civil_twilight_begin!) ?? "")"
                    self?.civTwiEnd.text = "End: \n\(self?.dateFormat(timeResult: i.civil_twilight_end!) ?? "")"
                    self?.nautTwiBegin.text = "Begins: \n\(self?.dateFormat(timeResult: i.nautical_twilight_begin!) ?? "")"
                    self?.nautTwiEnd.text = "End: \n\(self?.dateFormat(timeResult: i.nautical_twilight_end!) ?? "")"
                }
            }
        })
    }
}

extension ViewController {
    // Styling
    
    func apply() {
        style.apply(textStyle: .assessmentTitle, shadow: false, to: sunrise)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: sunset)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: solarNoon)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: astroTwiBegin)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: astroTwiEnd)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: civTwiBegin)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: civTwiEnd)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: nautTwiBegin)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: nautTwiEnd)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: dayLength)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: astroTwiliLbl)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: civiTwiliLbl)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: nautiTwiliLbl)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: latLbl)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: longLbl)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: dateLbl)
        style.apply(textStyle: .assessmentTitle, shadow: false, to: currentPostLbl)
        
        style.apply(textStyle: .textField, to: latTextField)
        style.apply(textStyle: .textField, to: longTextField)
        
        //style.apply(textStyle: .assessmentButton, state: .normal, to: requestButton)
        style.apply(marker: .unmarked, titleText: requestButton.titleLabel?.text, to: requestButton)
        
        style.apply(textStyle: .view, bgColor: .orange, shadow: false, to: view)
    }
}
