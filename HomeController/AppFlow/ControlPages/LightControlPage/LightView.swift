//
//  LightView.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 18.08.2022.
//

import UIKit

class LightView: UIView {
    
    let lightImageView = UIImageView()
    
    let intensitySlider = UISlider()
    
    let intensityTextView = UITextView()
    
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
        addSubview(lightImageView)
        addSubview(segmentControl)
        addSubview(intensitySlider)
        addSubview(intensityTextView)
        addSubview(modeTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
        
        backgroundColor = .lightGray
        
        lightImageView.styleImageView()
        
        intensitySlider.styleSlider()
        
        modeTextView.styleTextView(texts: "mode.Word".localized() + ": ")
        
        intensityTextView.styleTextView(texts: "intensity.Word".localized() + ": ")
                
    }
    
    private func addConstraints() {
        addConstraintsForLightImageView()
        addConstraintsForIntensityTextView()
        addConstraintsForIntensitySlider()
        addConstraintsForModeTextView()
        addConstraintsForSegmentControl()
    }
    
    private func addConstraintsForLightImageView() {
        
        NSLayoutConstraint.activate([
            lightImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            lightImageView.topAnchor.constraint(equalTo: topAnchor,constant: 160),
            
            lightImageView.widthAnchor.constraint(equalToConstant: 100),
            
            lightImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func addConstraintsForIntensityTextView() {
        
        NSLayoutConstraint.activate([
            intensityTextView.topAnchor.constraint(equalTo: lightImageView.bottomAnchor,constant: 38),
            
            intensityTextView.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            
            intensityTextView.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
        ])
    }
    
   private func addConstraintsForIntensitySlider() {
       
       NSLayoutConstraint.activate([
            intensitySlider.topAnchor.constraint(equalTo: intensityTextView.bottomAnchor,constant: 16),
        
            intensitySlider.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
        
            intensitySlider.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
       ])
    }
    
    private func addConstraintsForModeTextView() {
        
        NSLayoutConstraint.activate([
            modeTextView.topAnchor.constraint(equalTo: intensitySlider.bottomAnchor, constant: 38),
            
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
