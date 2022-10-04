//
//  ProfileFooterView.swift
//  presentation
//
//  Created by Nazim Asadov on 23.09.22.
//

import Foundation
import UIKit

class ProfileFooterView: UIView {
    
    private lazy var backView: UIView = {
       let view = UIView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemOrange.withAlphaComponent(0.1)
        addSubview(view)
        return view
    }()

    lazy var titleLabel: UILabel = {
       let label = UILabel()

        label.configureLabel(text: "How can we help you?", textColor: UIColor.eventOrange, textAlignment: NSTextAlignment.left)
        label.font = UIFont(font: FontFamily.Poppins.bold, size: 20)
        label.numberOfLines = 0

        backView.addSubview(label)
        return label
    }()
    
    private lazy var callImgView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFit
        imgView.image = Asset.helpDark.image.withTintColor(.systemOrange, renderingMode: .alwaysTemplate)
        imgView.tintColor = .eventOrange
        backView.addSubview(imgView)
        return imgView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        
        backView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
            make.right.bottom.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalTo(callImgView.snp.centerY)
        }
        
        callImgView.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-25)
            make.right.equalToSuperview().offset(-20)
        }
    }
}
