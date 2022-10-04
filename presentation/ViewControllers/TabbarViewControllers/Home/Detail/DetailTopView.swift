//
//  DetailDescriptionView.swift
//  presentation
//
//  Created by Nazim Asadov on 11.09.22.
//

import UIKit

class DetailTopView: UIView {
    
    lazy var eventNameLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: UIColor.label, textAlignment: NSTextAlignment.left)
        label.font = UIFont(font: FontFamily.Poppins.bold, size: 24)
        label.numberOfLines = 0

        addSubview(label)
        return label
    }()

    private lazy var eventTypeView: UIView = {
       let view = UIView()
        
        view.backgroundColor = .systemOrange
        view.clipsToBounds = true
        view.layer.cornerRadius = 11
        addSubview(view)
        return view
    }()
    
    lazy var eventTypeLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: UIColor.white, textAlignment: .center)
        label.font = UIFont(font: FontFamily.Poppins.semiBold, size: 13)
        label.numberOfLines = 0
        
        eventTypeView.addSubview(label)
        return label
    }()
    
    private lazy var titleDescriptionLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(text: "Description", textColor: UIColor.label, textAlignment: NSTextAlignment.left)
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        
        addSubview(label)
        return label
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
        eventNameLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.right.equalTo(eventTypeView.snp.left).offset(-10)
        }
        
        
        eventTypeView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(eventNameLbl.snp.top).offset(5)
        }
        
        eventTypeLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(3)
            make.bottom.equalToSuperview().offset(-3)
        }
        
        titleDescriptionLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(eventNameLbl.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
