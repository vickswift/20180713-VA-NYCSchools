//
//  DetailHighSchoolViewController.swift
//  20180713-VA-NYCSchools
//
//  Created by Victor  Adu on 7/13/18.
//  Copyright © 2018 Filmic. All rights reserved.
//

import UIKit
import MapKit

class DetailHighSchoolViewController: UIViewController {
    
    var selectedHighSchool: HighSchoolInfo?
    var dataService = DataService.instance
    
    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var schoolAddressLbl: UILabel!
    @IBOutlet weak var cityStateZipLbl: UILabel!
    
    @IBOutlet weak var avgSATMathScoreLbl: UILabel!
    @IBOutlet weak var avgSATReadingScoreLbl: UILabel!
    @IBOutlet weak var avgSATWritingScoreLbl: UILabel!

    @IBOutlet weak var schoolTelNumberBtnLbl: UIButton!
    @IBOutlet weak var schoolWebsiteBtnLbl: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataService.delegate = self
        
        DataService.instance.getAllNYCHighSchoolsAvgSATScores()

        self.title = selectedHighSchool?.school_name
        schoolNameLbl.text = selectedHighSchool?.school_name
        schoolAddressLbl.text = selectedHighSchool?.primary_address_line_1
        var text = (selectedHighSchool?.city ?? "") + ", "
        text += (selectedHighSchool?.state_code ?? "") + " - "
        text += (selectedHighSchool?.zip ?? "")
        
        cityStateZipLbl.text = text
        schoolTelNumberBtnLbl.setTitle(selectedHighSchool?.phone_number, for: .normal)
        schoolWebsiteBtnLbl.setTitle(selectedHighSchool?.website, for: .normal)
        
        //Add and center selected high school's location to mapView
        mapView.addAnnotation(selectedHighSchool!)
        centerMapOnLocation(CLLocation(latitude: selectedHighSchool!.schoolLatitude, longitude: selectedHighSchool!.schoolLongitude))
        
        selectedHighSchool?.title = selectedHighSchool?.school_name
        selectedHighSchool?.subtitle = selectedHighSchool?.city
    }
    
    func setAvgSATScores(){
        avgSATMathScoreLbl.text = "--.--"
        avgSATReadingScoreLbl.text = "--.--"
        avgSATWritingScoreLbl.text = "--.--"
            for satScores in dataService.schoolSATStats {
                if (selectedHighSchool?.dbn)! == satScores.dbn {
                    avgSATMathScoreLbl.text = "\(satScores.mathScore)"
                    avgSATReadingScoreLbl.text = "\(satScores.readingScore)"
                    avgSATWritingScoreLbl.text = "\(satScores.writingScore)"
                }
            }
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(selectedHighSchool!.coordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    //MARK: - IBAction methods
    @IBAction func callButtonPressed(_ sender: UIButton) {
        let telNumber = "tel://" + (selectedHighSchool?.phone_number ?? "")
        guard let telephoneNumber = URL(string:telNumber) else { return }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(telephoneNumber, options: [:])
        } else {
            UIApplication.shared.openURL(telephoneNumber)
        }
    }
    
    @IBAction func schoolWebsiteBtnPressed(_ sender: UIButton) {
        let webViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webViewController.applicationURL = "https://" + (selectedHighSchool?.website ?? "")
        navigationController?.pushViewController(webViewController, animated: true)
    }

}

extension DetailHighSchoolViewController: DataServiceDelegate {
    
    //MARK: - DataServiceDelegate methods
    func highSchoolsLoaded() {
        //
    }
    
    func highSchoolsAvgSATScoresLoaded() {
        //
        OperationQueue.main.addOperation {
            self.setAvgSATScores()
        }
    }
    
}
