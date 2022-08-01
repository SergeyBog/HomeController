//
//  HomePageTableViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import UIKit

class HomePageTableViewController: UITableViewController {

    var homePageViewModel: HomePageViewModel
    
    init(with viewModel: HomePageViewModel) {
        self.homePageViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }
    
    private func SetupUI() {
        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier:DeviceTableViewCell.identifier)
        configureViewModel()
        
        tableView.backgroundColor = .white
        title = "HomePage.Title".localized()
        
        homePageViewModel.getDevices()
    
    }
    
    private func configureViewModel() {
       homePageViewModel.reloadTableView = { [weak self] in
           DispatchQueue.main.async {
               self?.tableView.reloadData()
           }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePageViewModel.devices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let model = homePageViewModel.devices[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DeviceTableViewCell.identifier, for: indexPath) as! DeviceTableViewCell
        cell.configure(with: model) 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let model = homePageViewModel.devices[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        openDevice(model: model)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func openDevice(model device: Device) {
        homePageViewModel.seeDetails(with: device)
    }

}
