//
//  DetailCountryPageCell.swift
//  FlatstackTestTask
//
//  Created by Павел Прокопьев on 14.06.2021.
//

import UIKit

class DetailCountryPageCell: UITableViewCell {
   
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    fileprivate let bigLabel: UILabel = {
        let bl = UILabel()
        return bl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: UIImage, type: String, data: String){
        bigLabel.isHidden = true
        typeImageView.image = image
        typeLabel.text = type
        dataLabel.text = data
    }
    
    func configure(text: String){
        contentView.addSubview(bigLabel)
        typeImageView.isHidden = true
        typeLabel.isHidden = true
        dataLabel.isHidden = true
        bigLabel.isHidden = false
        bigLabel.sizeToFit()
        bigLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        bigLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        bigLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        bigLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
