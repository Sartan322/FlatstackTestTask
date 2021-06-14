//
//  CountryCell.swift
//  FlatstackTestTask
//
//  Created by Павел Прокопьев on 13.06.2021.
//

import UIKit

class CountryCell: UITableViewCell {
   
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var smallDiscrTextV: UITextView!
    
    @IBOutlet weak var discrLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configure(countryName: String, capital: String, smallDiscr: String?){
        countryNameLabel.text = countryName
        capitalLabel.text = capital
        if smallDiscr != nil {
            discrLabel.text = smallDiscr
            discrLabel.sizeToFit()
            
        } else {
            discrLabel.isHidden = true
            self.sizeToFit()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
