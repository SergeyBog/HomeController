//
//  RollerShutterControlPageViewController.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 22.07.2022.
//

import UIKit

class RollerShutterControlPageViewController: UIViewController {
    var rollerShutterControlPageViewModel: RollerShutterControlPageViewModel?
    
    private let rollerShutterImageView = UIImageView()
    
    private let positionSlider = UISlider()
    
    private let positionTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    
    }
    
    deinit {
        rollerShutterControlPageViewModel?.updateInfo()
    }
    

    func setUpUI() {
        stylizeElements()
        view.addSubview(rollerShutterImageView)
        view.addSubview(positionSlider)
        view.addSubview(positionTextView)
        addConstraints()
    }
    
    func stylizeElements() {
        self.title = rollerShutterControlPageViewModel?.selectedDevice.deviceName
        view.backgroundColor = .lightGray
        
        positionSlider.addTarget(self, action: #selector(sliderValueChanged(_slider:)), for: .valueChanged)
        
        rollerShutterImageView.styleImageViewWithImage(imageName: "DeviceRollerShutterIcon")
        positionSlider.styleSlider()
        positionTextView.styleTextView(texts: "Position.Word".localized() + ": ")
        
        positionSlider.value =  Float(rollerShutterControlPageViewModel?.selectedDevice.position ?? 0)/100
        
        positionTextView.text = "Position.Word".localized() + ": " + String(Int( rollerShutterControlPageViewModel?.selectedDevice.position ?? 0))
                
    }
    
    func addConstraints() {
        addConstraintsForRollerShutterImageView()
        addConstraintsForPositionTextView()
        addConstraintsForPositionSlider()
      
    }
    
    func addConstraintsForRollerShutterImageView() {
        
        rollerShutterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        rollerShutterImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 160).isActive = true
        
        rollerShutterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        rollerShutterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func addConstraintsForPositionTextView() {
        
        positionTextView.topAnchor.constraint(equalTo: rollerShutterImageView.bottomAnchor,constant: 38).isActive = true
        
        positionTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        positionTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
        
    }
    
    func addConstraintsForPositionSlider() {
        
        positionSlider.topAnchor.constraint(equalTo: positionTextView.bottomAnchor,constant: 16).isActive = true
        
        positionSlider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30).isActive = true
        
        positionSlider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30).isActive = true
    }
    
    
    @objc func sliderValueChanged(_slider: UISlider) {
        positionTextView.text = "Position.Word".localized() + ": " + String(Int( (_slider.value * 100).rounded(.up)))
        let value = (_slider.value * 100).rounded(.up)
        
        if value == 0 {
            rollerShutterControlPageViewModel?.selectedDevice.mode = "Open.Word".localized()
        } else if value > 0 && value < 100  {
            rollerShutterControlPageViewModel?.selectedDevice.mode = "OpenAt.Word".localized()
        } else {
            rollerShutterControlPageViewModel?.selectedDevice.mode = "Closed.Word".localized()
        }
        
        rollerShutterControlPageViewModel?.selectedDevice.position = Int(value)
        
        rollerShutterControlPageViewModel?.updateDevice()
       
    }

}
