//
//  HomePageTableViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import UIKit

class HomePageTableViewController: UITableViewController {

    var homePageViewModel: HomePageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier:DeviceTableViewCell.identifier)
        configureViewModel()
        
        
        tableView.backgroundColor = .white
        title = "HomePage.Title".localized()
        
        homePageViewModel?.getDevices()
        
        ///fix this userdefaults??
        /* let contentOffset = tableView.contentOffset
         tableView.reloadData()
         tableView.layoutIfNeeded()
         tableView.setContentOffset(contentOffset, animated: false)*/
        if homePageViewModel?.needToUpdateData == true {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    private func configureViewModel() {
       homePageViewModel?.reloadTableView = { [weak self] in
           DispatchQueue.main.async {
               self?.tableView.reloadData()
           }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePageViewModel?.devices.count ?? .zero
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = homePageViewModel?.devices[indexPath.row] else { return UITableViewCell()}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceTableViewCell.identifier, for: indexPath) as! DeviceTableViewCell
        cell.configure(with: model) 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = homePageViewModel?.devices[indexPath.row] else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        openDevice(model: model)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func openDevice(model device: Device) {
        homePageViewModel?.seeDetails(with: device)
    }

}
