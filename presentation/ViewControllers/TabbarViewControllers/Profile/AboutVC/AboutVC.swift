//
//  AboutVC.swift
//  presentation
//
//  Created by Nazim Asadov on 23.09.22.
//

import Foundation
import UIKit

public class AboutVC: BaseViewController<AboutVM> {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.backgroundColor = .appBackGroundColor
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        
        self.scrollView.addSubview(view)
        return view
    }()
    
    private lazy var descriptionLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: UIColor.label.withAlphaComponent(0.8), textAlignment: NSTextAlignment.left)
        label.text = "This application has been developed to provide find and book various events. An app also provides search functionality to the user. A user can search movies by keyword in a certain location.\nAn App provides access to content sourced from various platforms, including Ticketmaster, Universe, FrontGate Tickets, and Ticketmaster Resale (TMR). By default, returns events from many sources. With over 230K+ events available in this app, coverage spans different countries, including the United States, Canada, Mexico, Australia, New Zealand, the United Kingdom, Ireland, other European countries, and more.\nThis application has user authentication features,  user can register and sign in safely to the app. The user authentication is implemented using Firebase for email and password with username and surname. The user can save favorite events and share them with friends.\n\n Please do not hesitate to contact us with your comments and suggestions at nazim.asadov@iatc.edu.az.\n\nCreated by: \nNazim Asadov"
        label.font = UIFont(font: FontFamily.Poppins.light, size: 14)
        label.numberOfLines = 0

        scrollContentView.addSubview(label)
        return label
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.title = "About"
    }
    
    private func setupUI() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.contentLayoutGuide.snp.top)
            make.left.equalTo(self.scrollView.contentLayoutGuide.snp.left)
            make.right.equalTo(self.scrollView.contentLayoutGuide.snp.right)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(scrollContentView.snp.bottom).offset(-20)
        }
    }
}
