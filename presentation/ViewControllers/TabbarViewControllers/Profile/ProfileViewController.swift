//
//  SettingsViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 10.09.22.
//

import UIKit
import Firebase
import FirebaseAuth

public class ProfileViewController: BaseViewController<FirstViewModel>, UITableViewDelegate, UITableViewDataSource {
    
    var profileData: [ProfileData] = [
        ProfileData(name: "About", image: Asset.info1.image),
        ProfileData(name: "Favorites", image: Asset.heartMore.image),
        ProfileData(name: "Privacy Policy", image: Asset.policy.image),
        ProfileData(name: "Dark Mode", image: Asset.darkModeLast.image),
        ProfileData(name: "Logout", image: Asset.logout.image)
    ]
        
    private lazy var profileView : UIView = {
        let view = UIView()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemOrange
        
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var nameSurnameFirstLbl: UILabel = {
        let lbl = UILabel()
        
        let name = UserDefaults.standard.string(forKey: "User_Name")
        let surname = UserDefaults.standard.string(forKey: "User_Surname")
        lbl.configureLabel(textColor: .white, textAlignment: .left)
        lbl.numberOfLines = 1
        lbl.font = UIFont(font: FontFamily.Poppins.semiBold, size: 24)
        lbl.text = (name?.first?.uppercased() ?? "E") + (surname?.first?.uppercased() ?? "S")
        
        self.profileView.addSubview(lbl)
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: "\(ProfileTableViewCell.self)")
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .appBackGroundColor
        table.bounces = false
        
        self.view.addSubview(table)
        return table
    }()
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        
        let name = UserDefaults.standard.string(forKey: "User_Name")
        let surname = UserDefaults.standard.string(forKey: "User_Surname")
        label.configureLabel(textColor: .label, textAlignment: .left)
        label.font = UIFont(font: FontFamily.Poppins.semiBold, size: 18)
        label.text = (name ?? "").capitalized + " " + (surname ?? "").capitalized
        self.view.addSubview(label)
        
        return label
    }()
    
    private lazy var emailLbl: UILabel = {
        let label = UILabel()
        
        label.configureLabel(textColor: .label, textAlignment: .left)
        label.font = UIFont(font: FontFamily.Poppins.regular, size: 15)
        label.text = Auth.auth().currentUser?.email ?? ""
        self.view.addSubview(label)
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Profile"
        profileView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(profileView.snp.bottom).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        nameLbl.snp.makeConstraints { make in
            make.left.equalTo(profileView.snp.right).offset(20)
            make.top.equalTo(profileView.snp.top).offset(3)
        }
        
        emailLbl.snp.makeConstraints { make in
            make.left.equalTo(profileView.snp.right).offset(20)
            make.bottom.equalTo(profileView.snp.bottom).offset(-3)
        }
        
        nameSurnameFirstLbl.snp.makeConstraints { make in
            make.center.equalTo(profileView.snp.center)
        }
    }
    
    @objc func valueChanged(_ sender: UISwitch) {
        UIApplication.shared.windows.forEach { window in
            if sender.isOn {
                UserDefaults.standard.set(sender.isOn, forKey: "Phone_Mode")
                window.overrideUserInterfaceStyle = .dark
            }else {
                UserDefaults.standard.set(sender.isOn, forKey: "Phone_Mode")
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProfileTableViewCell.self)", for: indexPath) as! ProfileTableViewCell
        cell.setUIComponents(profileData[indexPath.row])
        cell.switchControl.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        if UserDefaults.standard.bool(forKey: "Phone_Mode") {
            cell.switchControl.setOn(true, animated: true)
        }else{
            cell.switchControl.setOn(false, animated: true)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let vc = router?.aboutVC()
            vc?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc!, animated: true)
        case 1:
            let vc = router?.favoritesViewController()
            vc?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc!, animated: true)
        case 2:
            let vc = router?.privacyVC()
            vc?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc!, animated: true)
        case profileData.count - 1:
            self.showAlert(with: "Are you sure about leaving profile?", preferredStyle: .alert, actions: [(title: "Close", style: .cancel), (title: "Logout", style: .destructive)]) { (index, _) in
                if index == 1 {
                    do {
                        UserDefaults.standard.removeObject(forKey: "User_Name")
                        UserDefaults.standard.removeObject(forKey: "User_Surname")
                        try Auth.auth().signOut()
                        let vc = self.router?.loginViewController()
                        vc?.modalTransitionStyle = .coverVertical
                        vc?.modalPresentationStyle = .overFullScreen
                        self.present(vc!, animated: true)
                    }catch {
                        print(error)
                    }
                }
            }
        default:
            break
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = ProfileFooterView()
        
        view.addTapGesture {
            if let url = URL(string: "tel://+994558394658"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        return view
    }
}
