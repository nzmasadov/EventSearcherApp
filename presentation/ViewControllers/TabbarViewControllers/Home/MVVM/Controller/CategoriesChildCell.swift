//
//  CategoriesChildCell.swift
//  presentation
//
//  Created by Nazim Asadov on 11.09.22.
//

import UIKit

class CategoriesChildCell: UICollectionViewCell {
    
    private lazy var imageView : UIImageView = {
        let imgView = UIImageView()

        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 16
        imgView.contentMode = .scaleAspectFit
        addSubview(imgView)
        return imgView
    }()

    private lazy var nameLbl: UILabel = {
        let label = UILabel()

        label.configureLabel(textColor: .label, textAlignment: .center)
        label.numberOfLines = 0
        label.font = UIFont(font: FontFamily.Poppins.medium, size: 14)
        addSubview(label)
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
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.3)
        clipsToBounds = true
        layer.cornerRadius = 16
        contentView.layer.cornerRadius = 16
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(35)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalTo(imageView.snp.centerX)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-3)
        }
    }
    
    func setUIComponents(_ category: Categories) {
        imageView.image = category.image.withTintColor(.label)
        nameLbl.text = category.name.rawValue
    }
}
