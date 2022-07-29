//
//  HeaterControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import UIKit

class HeaterControlPageViewController: UIViewController {

    var heaterControlPageViewModel: HeaterControlPageViewModel?
    
    private let heaterImageView = UIImageView()
    
    private let temperatureSlider = UISlider()
    
    private let temperatureTextView = UITextView()
    
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
        heaterControlPageViewModel?.updateInfo()
    }
    
    private func setUpUI() {
        stylizeElements()
        view.addSubview(heaterImageView)
        view.addSubview(segmentControl)
        view.addSubview(temperatureSlider)
        view.addSubview(temperatureTextView)
        view.addSubview(modeTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
        self.title = heaterControlPageViewModel?.selectedDevice.deviceName.localized()
        view.backgroundColor = .lightGray
        
        
        segmentControl.addTarget(self, action: #selector(segmentControlChange(_segmentControl:)), for: .valueChanged)
        
        temperatureSlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        
        if heaterControlPageViewModel?.selectedDevice.mode == "On.Word".localized() || heaterControlPageViewModel?.selectedDevice.mode == "ON"{
            segmentControl.selectedSegmentIndex = 0
            heaterImageView.image = UIImage(named: "DeviceHeaterOnIcon")
        } else {
            segmentControl.selectedSegmentIndex = 1
            heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
        }
        
        heaterImageView.styleImageView()
        temperatureSlider.styleSlider()
        modeTextView.styleTextView(texts: "Mode.Word".localized() + ": ")
        temperatureTextView.styleTextView(texts: "Temperature.Word".localized() + ": ")
        temperatureSlider.minimumValue = 7.0/100
        temperatureSlider.maximumValue = 27.0/100
        temperatureSlider.value =  Float(heaterControlPageViewModel?.selectedDevice.temperature ?? 0)/100
        
        temperatureTextView.text = "Temperature.Word".localized() + ": " +  String(heaterControlPageViewModel?.selectedDevice.temperature ?? 0) + "°"
                
    }
    
    private func addConstraints() {
        addConstraintsForHeaterImageView()
        addConstraintsForTemperatureTextView()
        addConstraintsForTemperatureSlider()
        addConstraintsForModeTextView()
        addConstraintsForSegmentControl()
    }
    
    private func addConstraintsForHeaterImageView() {
        
        heaterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        heaterImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 160).isActive = true
        
        heaterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        heaterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func addConstraintsForTemperatureTextView() {
        
        temperatureTextView.topAnchor.constraint(equalTo: heaterImageView.bottomAnchor,constant: 38).isActive = true
        
       temperatureTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        temperatureTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
        
    }
    
    private func addConstraintsForTemperatureSlider() {
        
        temperatureSlider.topAnchor.constraint(equalTo: temperatureTextView.bottomAnchor,constant: 16).isActive = true
        
        temperatureSlider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        temperatureSlider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
    }
    
    private func addConstraintsForModeTextView() {
        
        modeTextView.topAnchor.constraint(equalTo: temperatureSlider.bottomAnchor, constant: 38).isActive = true
        
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
            heaterImageView.image = UIImage(named: "DeviceHeaterOnIcon")
            heaterControlPageViewModel?.selectedDevice.mode = "On.Word".localized()
            heaterControlPageViewModel?.updateDevice()
            
        case 1:
            heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
            heaterControlPageViewModel?.selectedDevice.mode = "Off.Word".localized()
            heaterControlPageViewModel?.updateDevice()
            
        default:
            heaterImageView.image = UIImage(named: "DeviceHeaterOffIcon")
            
        }
    }
    
    @objc func sliderValueChanged(_slider: UISlider) {
        
        temperatureTextView.text = "Temperature.Word".localized() + ": " + String(round(_slider.value * 100 * 2)/2) + "°"
        
        heaterControlPageViewModel?.selectedDevice.temperature = Float(round(_slider.value * 100 * 2)/2)
        heaterControlPageViewModel?.updateDevice()
       
    }
    
   

}
