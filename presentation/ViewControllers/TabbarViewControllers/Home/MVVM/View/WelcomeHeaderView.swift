//
//  WelcomeHeaderView.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit
import SnapKit

class WelcomeHeaderView: UICollectionReusableView {
    
    lazy var welcomeLabel: UILabel = {
       let label = UILabel()

        label.configureLabel(text: "Hello,", textColor: UIColor.gray, textAlignment: NSTextAlignment.left)
        label.font = UIFont(font: FontFamily.Poppins.regular, size: 13)
        
//        var myMutableString = NSMutableAttributedString()
//                myMutableString = NSMutableAttributedString(string: "RoadMates")
//                myMutableString.addAttribute(NSAttributedString.Key.font, value: UIColor(named: "MainColor") as Any, range: NSRange(location: 4, length: 5))
//                label.attributedText = myMutableString

        addSubview(label)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
       let label = UILabel()

        let name = UserDefaults.standard.string(forKey: "User_Name")
        label.configureLabel(text: name?.capitalized, textColor: UIColor.systemOrange, textAlignment: NSTextAlignment.left)
        label.font = UIFont(font: FontFamily.Poppins.regular, size: 14)
        addSubview(label)
        return label
    }()
    
    lazy var messageLbl: UILabel = {
       let label = UILabel()

        label.configureLabel(text: "Discover Amazing Events", textColor: UIColor.systemOrange, textAlignment: NSTextAlignment.left)
        label.font = UIFont(font: FontFamily.Poppins.light, size: 25)
        addSubview(label)
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        welcomeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(welcomeLabel.snp.right).offset(5)
            make.centerY.equalTo(welcomeLabel.snp.centerY)
        }
        
        messageLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(17)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(5)

        }
    }
}
