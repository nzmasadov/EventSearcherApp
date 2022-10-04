//
//  LoginViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 18.09.22.
//

import Foundation
import UIKit
import SnapKit
import Firebase

public class LoginViewController: BaseViewController<LoginViewModel>, UITextFieldDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        self.scrollView.addSubview(view)
        return view
    }()
    
    private lazy var welcomeLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.bold , size: 32)
        label.text = "Welcome Back!"
        label.textColor = .systemOrange
        
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var subtitleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 15)
        label.text = "Login to your account"
        label.textColor = .gray
        label.textAlignment = .left
        
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = 10
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var firstStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = -2
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var firstlLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        label.text = "Email"
        label.textColor = .systemOrange
        
        return label
    }()
    
    private lazy var emailTextfield: UITextField = {
        let field = UITextField()
        
        field.font = UIFont(font: FontFamily.Poppins.regular , size: 15)
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.delegate = self
        field.returnKeyType = .next
        
        return field
    }()
    
    private lazy var secondStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = -2
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var secondLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        return view
    }()
    
    private lazy var passwordLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        label.text = "Password"
        label.textColor = .systemOrange
        
        return label
    }()
    
    private lazy var passwordTextfield: UITextField = {
        let field = UITextField()
        
        field.font = UIFont(font: FontFamily.Poppins.regular , size: 15)
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.returnKeyType = .done
        field.delegate = self
        
        return field
    }()
    
    private lazy var loginBtn: UIButton = {
       let btn = UIButton()
        
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.font = UIFont(font: FontFamily.Poppins.semiBold , size: 15)
        btn.setTitle("Sign in", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 24
        btn.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)

        view.addSubview(btn)
        return btn
    }()
    
    private lazy var buttonSubtitleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 13)
        label.text = "Don`t have an account?"
        label.textColor = .lightGray
        
        return label
    }()
    
    private lazy var signUpBtn: UIButton = {
       let btn = UIButton()
        
        btn.titleLabel?.font = UIFont(font: FontFamily.Poppins.semiBold , size: 13)
        btn.setTitle("Sign up", for: .normal)
        btn.setTitleColor(UIColor.systemOrange, for: .normal)
        btn.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var subStackView: UIStackView = {
       let stack = UIStackView()
        
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .fill
        
        contentView.addSubview(stack)
        return stack
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        subStackView.addArrangedSubview(buttonSubtitleLbl)
        subStackView.addArrangedSubview(signUpBtn)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func loginClicked() {
        guard let email = emailTextfield.text, !email.isEmpty,
           let password = passwordTextfield.text, !password.isEmpty else {
            self.showAlert(with: "Required fields cannot be empty")
            return
        }
        
        AppLoader.instance.showLoaderView()
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                self?.showAlert(with: "Unexpected error occured")
                AppLoader.instance.hideLoaderView()
                return
            }
                        
            let vc = self?.router?.tabbarViewControllers()
            vc?.modalPresentationStyle = .fullScreen
            self?.present(vc!, animated: true)
        }
        
//        vm?.signIn(email: email, password: password, succesfulHandler: { isSuccesful in
//            if !isSuccesful {
//                print("nzm Something gets wrong")
//            }else {
//                print("nzm succesfull login go tabbar")
//            }
//        })
    }
    
    @objc func signUpClicked() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
        
    private func setupUI() {
        firstStackView.addArrangedSubview(emailLbl)
        firstStackView.addArrangedSubview(emailTextfield)
        firstStackView.addArrangedSubview(firstlLineView)
        
        secondStackView.addArrangedSubview(passwordLbl)
        secondStackView.addArrangedSubview(passwordTextfield)
        secondStackView.addArrangedSubview(secondLineView)
        
        mainStackView.addArrangedSubview(firstStackView)
        mainStackView.addArrangedSubview(secondStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView.contentLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.scrollView.contentLayoutGuide.snp.left)
            make.right.equalTo(self.scrollView.contentLayoutGuide.snp.right)
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.bottom.equalTo(self.scrollView.contentLayoutGuide.snp.bottom)
            make.height.equalTo(self.view.frame.size.height)
        }
        
        welcomeLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(80)
        }
        
        subtitleLbl.snp.makeConstraints { make in
            make.top.equalTo(welcomeLbl.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLbl.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        emailTextfield.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
  
        passwordTextfield.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        firstlLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(56)
        }
        
        subStackView.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
            make.centerX.equalTo(loginBtn.snp.centerX)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        switch textField {
        case emailTextfield:
            emailTextfield.resignFirstResponder()
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            passwordTextfield.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
     }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }
}
