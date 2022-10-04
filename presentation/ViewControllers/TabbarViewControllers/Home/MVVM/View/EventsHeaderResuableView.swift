//
//  EventsHeaderResuableView.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit

class EventsHeaderResuableView: UIView {

    lazy var titleLabel: UILabel = {
       let label = UILabel()

        label.configureLabel(textColor: UIColor.label, textAlignment: NSTextAlignment.left)
        label.font = UIFont(font: FontFamily.Poppins.medium, size: 19)

        self.addSubview(label)
        return label
    }()

    lazy var viewLabel: UILabel = {
       let label = UILabel()

        label.configureLabel(text: "See all", textColor: UIColor.systemOrange, textAlignment: NSTextAlignment.right)
        label.font = UIFont(font: FontFamily.Poppins.bold, size: 14)
        self.addSubview(label)
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
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }
        
        viewLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    
    func viewAllTapped(with type: EventsType.EventCategories, navigation: UINavigationController, router: Router) {
        viewLabel.isUserInteractionEnabled = true
        viewLabel.addTapGesture {
            let vc = router.pagedEventsViewController()
            vc.eventType = type
            vc.hidesBottomBarWhenPushed = true
            navigation.pushViewController(vc, animated: true)
        }
    }
}
