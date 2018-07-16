//
//  HighSchoolCell.swift
//  20180713-VA-NYCSchools
//
//  Created by Victor  Adu on 7/13/18.
//  Copyright © 2018 Filmic. All rights reserved.
//

import UIKit

class HighSchoolCell: UITableViewCell {
    
    @IBOutlet weak var highSchoolNameLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var telephoneLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(name: HighSchoolInfo) {
        highSchoolNameLbl.text = name.school_name
        
        var text = "Distr: \(name.council_district ?? ""),"
        text += " \(name.city ?? "")" + " - "
        text += "\(name.borough ?? "")"
        
        cityLbl.text =  text
        telephoneLbl.text = String("Tel: \(name.phone_number ?? "")")
    }
    
}

