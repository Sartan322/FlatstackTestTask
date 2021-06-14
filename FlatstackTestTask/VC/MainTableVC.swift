//
//  MainTableVC.swift
//  FlatstackTestTask
//
//  Created by Павел Прокопьев on 13.06.2021.
//

import UIKit
import Nuke

class MainTableVC: UIViewController {
    
    @IBOutlet weak var countryTableView: UITableView!

    let cellIdentifier = "CountryCell"
    let networkingService = NetworkingService.shared()
    var countries: [Countries] = []
    //var nextUrl: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    var url: [String] = ["", "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
//        networkingService.doRequest(url: url) { countries in
//            self.countries = countries
//            //print(countries)
//            if let nextUrl = countries.first?.next {
//                self.networkingService.doRequest(url: nextUrl) { newCountries in
//                    self.countries.append(contentsOf: newCountries)
//                    self.countryTableView.reloadData()
//                }
//            }
//            self.countryTableView.reloadData()
//        }
    }
    
    func loadData(){
        if self.url[0] != self.url[1] {
            networkingService.doRequest(url: url[1]) { countries in
                self.countries.append(contentsOf: countries)
                self.url[0] = self.url[1]
                self.url[1] = countries.first?.next ?? ""
                print("url: " + self.url[0])
                print("nextUrl: " + self.url[1])
                self.countryTableView.reloadData()
            }
        }
    }

    // MARK: - Navigation


}

extension MainTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryCell
        let imageRequest = ImageRequest(url: URL(string: self.countries[indexPath.row].flag!))
        Nuke.loadImage(with: imageRequest, into: cell.img)
        cell.configure(countryName: self.countries[indexPath.row].name, capital: self.countries[indexPath.row].capital, smallDiscr: self.countries[indexPath.row].descriptionSmall)
    
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (countryTableView.contentSize.height - 50 - scrollView.frame.size.height) {
            print("load")
            loadData()
        }
    }
    
}
