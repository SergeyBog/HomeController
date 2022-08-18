//
//  RollerShutterView.swift
//  HomeController
//
//  Created by Sergey Bohachenko on 17.08.2022.
//

import UIKit

class RollerShutterView: UIView {

    private let rollerShutterImageView = UIImageView()
    
    let positionSlider = UISlider()
    
    let positionTextView = UITextView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        stylizeElements()
        addSubview(rollerShutterImageView)
        addSubview(positionSlider)
        addSubview(positionTextView)
        addConstraints()
    }
    
    private func stylizeElements() {
        
        self.backgroundColor = .lightGray
        
        rollerShutterImageView.styleImageViewWithImage(imageName: "DeviceRollerShutterIcon")
        
        positionSlider.styleSlider()
        
        positionTextView.styleTextView(texts: "position.Word".localized() + ": ")
                
    }
    
    private func addConstraints() {
        addConstraintsForRollerShutterImageView()
        addConstraintsForPositionTextView()
        addConstraintsForPositionSlider()
    }
    
    private func addConstraintsForRollerShutterImageView() {
        
        NSLayoutConstraint.activate([
            rollerShutterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                
            rollerShutterImageView.topAnchor.constraint(equalTo: topAnchor,constant: 160),
                
            rollerShutterImageView.widthAnchor.constraint(equalToConstant: 100),
                
            rollerShutterImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func addConstraintsForPositionTextView() {
        
        NSLayoutConstraint.activate([
            positionTextView.topAnchor.constraint(equalTo: rollerShutterImageView.bottomAnchor,constant: 38),
            
            positionTextView.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            
            positionTextView.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
        ])
    }
    
    private func addConstraintsForPositionSlider() {
        
        NSLayoutConstraint.activate([
            positionSlider.topAnchor.constraint(equalTo: positionTextView.bottomAnchor,constant: 16),
        
            positionSlider.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            
            positionSlider.rightAnchor.constraint(equalTo: rightAnchor,constant: -30)
        ])
    }

}
