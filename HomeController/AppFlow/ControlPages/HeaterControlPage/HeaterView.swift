//
//  HeaterView.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 18.08.2022.
//

import UIKit

class HeaterView: UIView {

    let heaterImageView = UIImageView()
    
    let temperatureSlider = UISlider()
    
    let temperatureTextView = UITextView()
    
    let modeTextView = UITextView()
    
    let segmentControl: UISegmentedControl = {
        let items = ["on.Word".localized(),"off.Word".localized()]
        let segControl = UISegmentedControl(items: items)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        return segControl
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        stylizeElements()
        addSubview(heaterImageView)
        addSubview(segmentControl)
        addSubview(temperatureSlider)
        addSubview(temperatureTextView)
        addSubview(modeTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
    
        backgroundColor = .lightGray
        
        heaterImageView.styleImageView()
        
        temperatureSlider.styleSlider()
        
        modeTextView.styleTextView(texts: "mode.Word".localized() + ": ")
        
        temperatureTextView.styleTextView(texts: "temperature.Word".localized() + ": ")
        
        temperatureSlider.minimumValue = 7.0/100
        
        temperatureSlider.maximumValue = 28.0/100
    }
    
    private func addConstraints() {
        addConstraintsForHeaterImageView()
        addConstraintsForTemperatureTextView()
        addConstraintsForTemperatureSlider()
        addConstraintsForModeTextView()
        addConstraintsForSegmentControl()
    }
    
    private func addConstraintsForHeaterImageView() {
        
        NSLayoutConstraint.activate([
            heaterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            heaterImageView.topAnchor.constraint(equalTo: topAnchor,constant: 160),
            
            heaterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            heaterImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func addConstraintsForTemperatureTextView() {
        
        NSLayoutConstraint.activate([
            temperatureTextView.topAnchor.constraint(equalTo: heaterImageView.bottomAnchor,constant: 38),
            
            temperatureTextView.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            
            temperatureTextView.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
        ])
    }
    
    private func addConstraintsForTemperatureSlider() {
        
        NSLayoutConstraint.activate([
            temperatureSlider.topAnchor.constraint(equalTo: temperatureTextView.bottomAnchor,constant: 16),
            
            temperatureSlider.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            
            temperatureSlider.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
        ])
    }
    
    private func addConstraintsForModeTextView() {
        
        NSLayoutConstraint.activate([
            modeTextView.topAnchor.constraint(equalTo: temperatureSlider.bottomAnchor, constant: 38),
            
            modeTextView.heightAnchor.constraint(equalToConstant: 40),
            
            modeTextView.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            
            modeTextView.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
        ])
    }
    
    private func addConstraintsForSegmentControl() {
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: modeTextView.bottomAnchor, constant: 16),
            
            segmentControl.heightAnchor.constraint(equalToConstant: 40),
            
            segmentControl.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            
            segmentControl.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
        ])
    }
}
