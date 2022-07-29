//
//  ControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 21.07.2022.
//

import UIKit

class LightControlPageViewController: UIViewController {

    var lightControlPageViewModel: LightControlPageViewModel?
   
    private let lightImageView = UIImageView()
    
    private let intensitySlider = UISlider()
    
    private let intensityTextView = UITextView()
    
    private let modeTextView = UITextView()
    
    private let segmentControl: UISegmentedControl = {
        let items = ["On.Word".localized(),"Off.Word".localized()]
        let segControl = UISegmentedControl(items: items)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    deinit {
        lightControlPageViewModel?.updateInfo()
    }
    
    private func setUpUI() {
        stylizeElements()
        view.addSubview(lightImageView)
        view.addSubview(segmentControl)
        view.addSubview(intensitySlider)
        view.addSubview(intensityTextView)
        view.addSubview(modeTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
        self.title = lightControlPageViewModel?.selectedDevice.deviceName.localized()
        view.backgroundColor = .lightGray
        
        segmentControl.addTarget(self, action: #selector(segmentControlChange(_segmentControl:)), for: .valueChanged)
        
        intensitySlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        if lightControlPageViewModel?.selectedDevice.mode == "On.Word".localized() || lightControlPageViewModel?.selectedDevice.mode == "ON" {
            segmentControl.selectedSegmentIndex = 0
            lightImageView.image = UIImage(named: "DeviceLightOnIcon")
        } else {
            segmentControl.selectedSegmentIndex = 1
            lightImageView.image = UIImage(named: "DeviceLightOffIcon")
        }
        
        lightImageView.styleImageView()
        intensitySlider.styleSlider()
        modeTextView.styleTextView(texts: "Mode.Word".localized() + ": ")
        intensityTextView.styleTextView(texts: "Intensity.Word".localized() + ": ")
        
        intensitySlider.value =  Float(lightControlPageViewModel?.selectedDevice.intensity ?? 0)/100
        
        intensityTextView.text = "Intensity.Word".localized() + ": " + String(lightControlPageViewModel?.selectedDevice.intensity ?? 0)
                
    }
    
    private func addConstraints() {
        addConstraintsForLightImageView()
        addConstraintsForIntensityTextView()
        addConstraintsForIntensitySlider()
        addConstraintsForModeTextView()
        addConstraintsForSegmentControl()
    }
    
    private func addConstraintsForLightImageView() {
        
        lightImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        lightImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 160).isActive = true
        
        lightImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        lightImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func addConstraintsForIntensityTextView() {
        
        intensityTextView.topAnchor.constraint(equalTo: lightImageView.bottomAnchor,constant: 38).isActive = true
        
        intensityTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        intensityTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
        
    }
    
   private func addConstraintsForIntensitySlider() {
        
        intensitySlider.topAnchor.constraint(equalTo: intensityTextView.bottomAnchor,constant: 16).isActive = true
        
        intensitySlider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        intensitySlider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
    }
    
    private func addConstraintsForModeTextView() {
        
        modeTextView.topAnchor.constraint(equalTo: intensitySlider.bottomAnchor, constant: 38).isActive = true
        
        modeTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        modeTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        modeTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
    }
    
    private func addConstraintsForSegmentControl() {
        
        segmentControl.topAnchor.constraint(equalTo: modeTextView.bottomAnchor, constant: 16).isActive = true
        
        segmentControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
    }
    
    @objc func segmentControlChange(_segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            lightImageView.image = UIImage(named: "DeviceLightOnIcon")
            lightControlPageViewModel?.selectedDevice.mode = "On.Word".localized()
            lightControlPageViewModel?.updateDevice()
            
        case 1:
            lightImageView.image = UIImage(named: "DeviceLightOffIcon")
            lightControlPageViewModel?.selectedDevice.mode = "Off.Word".localized()
            lightControlPageViewModel?.updateDevice()
            
        default:
            lightImageView.image = UIImage(named: "DeviceLightOffIcon")
        }
    }
    
    @objc func sliderValueChanged(_slider: UISlider) {
        intensityTextView.text = "Intensity.Word".localized() + ": " + String(Int((_slider.value * 100)))
        lightControlPageViewModel?.selectedDevice.intensity = Int((_slider.value * 100).rounded(.up))
        lightControlPageViewModel?.updateDevice()
        
    }
    

}
