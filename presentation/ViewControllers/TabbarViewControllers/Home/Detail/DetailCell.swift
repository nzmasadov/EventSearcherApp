//
//  DetailCell.swift
//  presentation
//
//  Created by Nazim Asadov on 11.09.22.
//

import Foundation
import UIKit

class DetailCell: UICollectionViewCell {
        
    private lazy var backView : UIView = {
        let view = UIView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.contentMode = .scaleAspectFit
        contentView.addSubview(view)
        return view
    }()
    
    private lazy var imageView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.contentMode = .scaleAspectFit
        backView.addSubview(imgView)
        
        return imgView
    }()
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: UIColor.gray, textAlignment: .left)
        label.font = UIFont(font: FontFamily.Poppins.regular, size: 13)
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var subtitleLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: UIColor.label, textAlignment: .left)
        label.numberOfLines = 2
        label.font = UIFont(font: FontFamily.Poppins.medium, size: 14)
        contentView.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .appBackGroundColor
        clipsToBounds = true
        layer.cornerRadius = 16
        
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
//            make.left.top.bottom.equalToSuperview()
            make.width.height.equalTo(68)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(34)
            make.centerX.equalTo(backView.snp.centerX)
            make.centerY.equalTo(backView.snp.centerY)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.left.equalTo(backView.snp.right).offset(14)
            make.top.equalTo(backView.snp.top).offset(2)
        }
        
        subtitleLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(1)
            make.left.equalTo(backView.snp.right).offset(14)
            make.right.equalToSuperview().offset(-4)
        }
    }
    
    func setUIComponents(_ detail: DetailModel) {
        backView.backgroundColor = detail.backgroundColor.withAlphaComponent(0.1)
        imageView.image = detail.image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = detail.backgroundColor
        titleLbl.text = detail.title
        subtitleLbl.text = detail.subtitle
    }
}
