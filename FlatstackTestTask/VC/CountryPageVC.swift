//
//  CountryPageVC.swift
//  FlatstackTestTask
//
//  Created by Павел Прокопьев on 14.06.2021.
//

import UIKit
import Nuke

class CountryPageVC: UIViewController {
    let cellIdentifier = "DetailCountryPageCell"
    @IBOutlet weak var tableView: UITableView!
    
    var country: Country!
    
    fileprivate let collectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(CollectionVCustomCell.self, forCellWithReuseIdentifier: "cell")
            return cv
        }()
    
    func configure(){
        view.addSubview(collectionView)
            collectionView.backgroundColor = .white
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            collectionView.heightAnchor.constraint(equalToConstant: 240/820).isActive = true
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib.init(nibName: "BigCountryCell", bundle: nil), forCellReuseIdentifier: "BigCountryCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configure()
    }
    


}

extension CountryPageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionVCustomCell
        let imageRequest = ImageRequest(url: URL(string: country.image!))
        Nuke.loadImage(with: imageRequest, into: cell.bg)
        return cell
    }
}

extension CountryPageVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailCountryPageCell
        switch indexPath.row {
        case 0:
            cell.configure(image: #imageLiteral(resourceName: "ios_scan_3749365766"), type: "Capital", data: country.capital!)
        case 1:
            cell.configure(image: #imageLiteral(resourceName: "ios_scan_3749365766"), type: "Population", data: country.population!)
        case 2:
            cell.configure(image: #imageLiteral(resourceName: "ios_scan_3749365766"), type: "Continent", data: country.continent!)
        case 3:
            let bigCell = tableView.dequeueReusableCell(withIdentifier: "BigCountryCell", for: indexPath) as! BigCountryCell
            bigCell.textlabel.text = country.descriptionBig!
            return bigCell
        default:
            break
        }
    
        return cell
    }
}


class CollectionVCustomCell: UICollectionViewCell {
    
    
    fileprivate let bg: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
                iv.layer.cornerRadius = 12
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        bg.image = #imageLiteral(resourceName: "ios_scan_2220053682")

        
        contentView.addSubview(bg)

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

