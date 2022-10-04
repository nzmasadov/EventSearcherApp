//
//  DetailHeaderView.swift
//  presentation
//
//  Created by Nazim Asadov on 12.09.22.
//

import UIKit

class DetailHeaderView: UIView {
    
    lazy var backView: UIView = {
       let img = UIView()
                
        img.backgroundColor = .black.withAlphaComponent(0.3)
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        addSubview(img)
        return img
    }()
    
    lazy var backBtn: UIButton = {
       let btn = UIButton()
                
        btn.contentMode = .scaleAspectFill
        
        btn.setImage(Asset.backArrowLast.image, for: .normal)
        self.backView.addSubview(btn)
        return btn
    }()

    lazy var saveView: UIView = {
       let img = UIView()
                
        img.backgroundColor = .black.withAlphaComponent(0.3)
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        addSubview(img)
        return img
    }()
    
    lazy var saveBtn: UIButton = {
       let btn = UIButton()
                
        btn.contentMode = .scaleAspectFill
        btn.setImage(Asset.icWhiteStar.image, for: .normal)
        saveView.addSubview(btn)
        return btn
    }()
    
    lazy var shareView: UIView = {
       let img = UIView()
                
        img.backgroundColor = .black.withAlphaComponent(0.3)
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        addSubview(img)
        return img
    }()
    
    lazy var shareBtn: UIButton = {
       let btn = UIButton()
                
        btn.contentMode = .scaleAspectFill
        
        btn.setImage(Asset.shareIcon.image, for: .normal)
        shareView.addSubview(btn)
        return btn
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
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.height.width.equalTo(40)
            make.bottom.equalToSuperview().offset(10)
        }
        
        backBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        shareView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(40)
            make.bottom.equalToSuperview().offset(10)
        }
        
        shareBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        saveView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalTo(shareView.snp.left).offset(-20)
            make.height.width.equalTo(40)
            make.bottom.equalToSuperview().offset(10)
        }
        
        saveBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }        
    }
}
