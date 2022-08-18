//
//  HeaterControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import UIKit

class HeaterControlPageViewController: UIViewController {

    var heaterControlPageViewModel: HeaterControlPageViewModel
    var heaterView: HeaterView
    
    init(with viewModel: HeaterControlPageViewModel) {
        self.heaterControlPageViewModel = viewModel
        self.heaterView = HeaterView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        heaterControlPageViewModel.updateInfo()
    }
    
    override func loadView() {
        configureView()
        view = heaterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureView() {
        self.title = heaterControlPageViewModel.getDeviceName()
        
        heaterView.segmentControl.addTarget(self, action: #selector(segmentControlChange(_segmentControl:)), for: .valueChanged)
        
        heaterView.temperatureSlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        if heaterControlPageViewModel.getDeviceMode() == 0 {
            heaterView.segmentControl.selectedSegmentIndex = 0
            heaterView.heaterImageView.image = UIImage(named: "DeviceHeaterOnIcon")
            
        } else {
            heaterView.segmentControl.selectedSegmentIndex = 1
            heaterView.heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
        }
        
        heaterView.temperatureSlider.value =  heaterControlPageViewModel.getDeviceTemperatureInFloat()
        
        heaterView.temperatureTextView.text = heaterControlPageViewModel.getDeviceTemperatureInString()
    }
   
    @objc func segmentControlChange(_segmentControl: UISegmentedControl) {
        switch heaterView.segmentControl.selectedSegmentIndex {
        case 0:
            heaterView.heaterImageView.image = UIImage(named: "DeviceHeaterOnIcon")
            heaterControlPageViewModel.updateMode(with: "on.Word".localized())
            
        case 1:
            heaterView.heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
            heaterControlPageViewModel.updateMode(with: "off.Word".localized())
            
        default:
            heaterView.heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
        }
    }
    
    @objc func sliderValueChanged(_slider: UISlider) {
        heaterView.temperatureTextView.text = heaterControlPageViewModel.temperatureValueChanged(sliderValue: _slider.value)
    }
    
}
