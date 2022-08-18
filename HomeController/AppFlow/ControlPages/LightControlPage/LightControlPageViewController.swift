//
//  ControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import UIKit

class LightControlPageViewController: UIViewController {

    var lightControlPageViewModel: LightControlPageViewModel
    var lightView: LightView
    
    init(with viewModel: LightControlPageViewModel) {
        self.lightControlPageViewModel = viewModel
        self.lightView = LightView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        lightControlPageViewModel.updateInfo()
    }
    override func loadView() {
        configureView()
        view = lightView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureView() {
        self.title = lightControlPageViewModel.getDeviceName()
    
        lightView.segmentControl.addTarget(self, action: #selector(segmentControlChange(_segmentControl:)), for: .valueChanged)
        
        lightView.intensitySlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        if lightControlPageViewModel.getDeviceMode() == 0 {
            lightView.segmentControl.selectedSegmentIndex = 0
            lightView.lightImageView.image = UIImage(named: "DeviceLightOnIcon")
            
        } else {
            lightView.segmentControl.selectedSegmentIndex = 1
            lightView.lightImageView.image = UIImage(named: "DeviceLightOffIcon")
        }
        
        lightView.intensitySlider.value =  lightControlPageViewModel.getDeviceIntensityInFloat()
        
        lightView.intensityTextView.text = lightControlPageViewModel.getDeviceIntensityInString()
        
    }
    
    @objc func segmentControlChange(_segmentControl: UISegmentedControl) {
        switch lightView.segmentControl.selectedSegmentIndex {
        case 0:
            lightView.lightImageView.image = UIImage(named: "DeviceLightOnIcon")
            lightControlPageViewModel.updateMode(with: "on.Word".localized())
            
        case 1:
            lightView.lightImageView.image = UIImage(named: "DeviceLightOffIcon")
            lightControlPageViewModel.updateMode(with: "off.Word".localized())
            
        default:
            lightView.lightImageView.image = UIImage(named: "DeviceLightOffIcon")
        }
    }
    
    @objc func sliderValueChanged(_slider: UISlider) {
        lightView.intensityTextView.text = lightControlPageViewModel.intentsityValueChanged(sliderValue: _slider.value)
    }
    
}
