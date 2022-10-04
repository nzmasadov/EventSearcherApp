//
//  ProfileTableViewCell.swift
//  presentation
//
//  Created by Nazim Asadov on 13.09.22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
    private lazy var backView: UIView = {
       let view = UIView()
        
        view.backgroundColor = .appBackGroundColor
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFill
        imgView.tintColor = .systemOrange
        backView.addSubview(imgView)
        return imgView
    }()
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: .label, textAlignment: .left)
        label.numberOfLines = 1
        label.font = UIFont(font: FontFamily.Poppins.regular, size: 16)
        backView.addSubview(label)
        return label
    }()
    
    private lazy var subStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.distribution = .equalCentering
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .fill
        
        backView.addSubview(stack)
        return stack
    }()
    
    private lazy var indicatorImgView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 16
        imgView.contentMode = .scaleAspectFit
        imgView.image = Asset.icVektorMini.image
        
        subStackView.addArrangedSubview(imgView)
        return imgView
    }()
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        
        switchControl.isHidden = true
        switchControl.onTintColor = .systemOrange
        subStackView.addArrangedSubview(switchControl)
        return switchControl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 16
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-15)
            make.width.height.equalTo(20)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.left.equalTo(imgView.snp.right).offset(25)
            make.centerY.equalTo(imgView.snp.centerY)
        }
        
        subStackView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(imgView.snp.centerY)
            make.height.equalTo(31)
        }
        switchControl.snp.makeConstraints { make in
            make.height.equalTo(31)
            make.width.equalTo(49)
        }
        indicatorImgView.snp.makeConstraints { make in
            make.width.height.equalTo(18)
        }
    }
    
    func setUIComponents(_ profileData: ProfileData) {
        titleLbl.text = profileData.name
        if profileData.name == "Logout" {
            imgView.image = profileData.image?.withTintColor(.systemOrange).withRenderingMode(.alwaysTemplate)
            imgView.tintColor = .systemOrange.withAlphaComponent(0.9)
            indicatorImgView.isHidden = true
        }else if profileData.name == "Dark Mode"  {
            switchControl.isHidden = false
            indicatorImgView.isHidden = true
            imgView.image = profileData.image?.withTintColor(.systemOrange).withRenderingMode(.alwaysTemplate)
            imgView.tintColor = .systemOrange.withAlphaComponent(0.5)
        } else if profileData.name == "Contact us" {
            indicatorImgView.isHidden = true
            imgView.image = profileData.image?.withTintColor(.systemOrange).withRenderingMode(.alwaysTemplate)
            imgView.tintColor = .systemOrange.withAlphaComponent(0.5)
        }else {
            imgView.image = profileData.image?.withTintColor(.systemOrange).withRenderingMode(.alwaysTemplate)
            imgView.tintColor = .systemOrange.withAlphaComponent(0.5)
        }
    }
}
