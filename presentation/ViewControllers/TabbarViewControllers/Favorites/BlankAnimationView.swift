//
//  BlankAnimationView.swift
//  presentation
//
//  Created by Nazim Asadov on 12.09.22.
//

import Foundation
import UIKit
import Lottie

class BlankAnimationView: UIView {
    
    lazy var animationStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 24

        addSubview(stack)
        return stack
    }()
    
    lazy var animationView: AnimationView = {
        let view = AnimationView()
        view.animation = Animation.named("notfound")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.clear
        view.backgroundBehavior = .pauseAndRestore
        view.loopMode = .loop
        view.play()
        
        animationStackView.addArrangedSubview(view)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(font: FontFamily.Poppins.medium, size: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "You don`t have any favorites yet"
        lbl.textColor = .gray
        
        animationStackView.addArrangedSubview(lbl)
        return lbl
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {

        animationView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        animationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        animationStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(176)
            make.height.equalTo(220)
        }
//        animationStackView.easy.layout(Edges())
//        animationStackView.easy.layout(Size(CGSize(width: 176, height: 220)))
    }
}
