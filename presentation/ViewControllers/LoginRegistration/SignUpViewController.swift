//
//  SignUpViewController.swift
//  presentation
//
//  Created by Nazim Asadov on 18.09.22.
//

import UIKit
import Firebase
import FirebaseFirestore

public class SignUpViewController: BaseViewController<SignUpViewModel>, UITextFieldDelegate {
    
    let database = Firestore.firestore()
    
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
    
    private lazy var signUpLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.bold , size: 32)
        label.text = "Sign Up"
        label.textColor = .systemOrange
        
        self.contentView.addSubview(label)
        return label
    }()
    
    private lazy var subtitleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 13)
        label.text = "Create your new account"
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
    
    private lazy var childStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = -2
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        return view
    }()
    
    private lazy var childStackView2: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = -2
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        return view
    }()
    
    private lazy var childStackView3: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = -2
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var lineView3: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        return view
    }()

    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        label.text = "Name"
        label.textColor = .systemOrange
        
        return label
    }()
    
    private lazy var childStackView4: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = -2
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var lineView4: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        return view
    }()
    
    private lazy var childStackView5: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution  = .equalSpacing
        stack.spacing = -2
        
        self.contentView.addSubview(stack)
        return stack
    }()
    
    private lazy var lineView5: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        return view
    }()
    
    private lazy var nameTextfield: UITextField = {
        let field = UITextField()
        
        field.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        field.returnKeyType = .next
        field.delegate = self
        
        return field
    }()
    
    private lazy var surnameLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        label.text = "Surname"
        label.textColor = .systemOrange
        
        return label
    }()
    
    private lazy var surnameTextfield: UITextField = {
        let field = UITextField()
        
        field.font = UIFont(font: FontFamily.Poppins.regular , size:14)
        field.returnKeyType = .next
        field.delegate = self

        return field
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
        
        field.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        field.clipsToBounds = true
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.delegate = self
        
        return field
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
        
        field.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        field.borderStyle = .none
        field.returnKeyType = .next
        field.isSecureTextEntry = true
        field.delegate = self

        return field
    }()
    
    private lazy var reenterLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        label.text = "Re-enter Password"
        label.textColor = .systemOrange
        return label
    }()
    
    private lazy var reenterTextfield: UITextField = {
        let field = UITextField()
        
        field.font = UIFont(font: FontFamily.Poppins.regular , size: 14)
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        field.delegate = self
        
        return field
    }()
    
    private lazy var signUpBtn: UIButton = {
       let btn = UIButton()
        
        btn.backgroundColor = .systemOrange
        btn.titleLabel?.font = UIFont(font: FontFamily.Poppins.semiBold , size: 15)
        btn.setTitle("Create account", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 24
        btn.addTarget(self, action: #selector(createAccount), for: .touchUpInside)

        view.addSubview(btn)
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
    
    private lazy var buttonSubtitleLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(font: FontFamily.Poppins.regular , size: 13)
        label.text = "Already have an account ?"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var signInBtn: UIButton = {
       let btn = UIButton()
        
        btn.titleLabel?.font = UIFont(font: FontFamily.Poppins.semiBold , size: 13)
        btn.setTitle("Sign in", for: .normal)
        btn.setTitleColor(UIColor.systemOrange, for: .normal)
        btn.addTarget(self, action: #selector(signInClicked), for: .touchUpInside)
        
        return btn
    }()

    override public func viewDidLoad() {
        super.viewDidLoad()

        childStackView.addArrangedSubview(nameLbl)
        childStackView.addArrangedSubview(nameTextfield)
        childStackView.addArrangedSubview(lineView)
        
        childStackView2.addArrangedSubview(surnameLbl)
        childStackView2.addArrangedSubview(surnameTextfield)
        childStackView2.addArrangedSubview(lineView2)
        
        childStackView3.addArrangedSubview(emailLbl)
        childStackView3.addArrangedSubview(emailTextfield)
        childStackView3.addArrangedSubview(lineView3)
        
        childStackView4.addArrangedSubview(passwordLbl)
        childStackView4.addArrangedSubview(passwordTextfield)
        childStackView4.addArrangedSubview(lineView4)
        
        childStackView5.addArrangedSubview(reenterLbl)
        childStackView5.addArrangedSubview(reenterTextfield)
        childStackView5.addArrangedSubview(lineView5)
        
        mainStackView.addArrangedSubview(childStackView)
        mainStackView.addArrangedSubview(childStackView2)
        mainStackView.addArrangedSubview(childStackView3)
        mainStackView.addArrangedSubview(childStackView4)
        mainStackView.addArrangedSubview(childStackView5)
        
        subStackView.addArrangedSubview(buttonSubtitleLbl)
        subStackView.addArrangedSubview(signInBtn)
        
        setupUI()
    }
    
    private func setupUI() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
        
        signUpLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(80)
        }
        
        subtitleLbl.snp.makeConstraints { make in
            make.top.equalTo(signUpLbl.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        lineView2.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        lineView3.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        lineView4.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        lineView5.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        nameTextfield.snp.makeConstraints { make in
            make.height.equalTo(38)
        }
        
        surnameTextfield.snp.makeConstraints { make in
            make.height.equalTo(38)
        }
        
        emailTextfield.snp.makeConstraints { make in
            make.height.equalTo(38)
        }
        
        passwordTextfield.snp.makeConstraints { make in
            make.height.equalTo(38)
        }
        
        reenterTextfield.snp.makeConstraints { make in
            make.height.equalTo(38)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLbl.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(56)
        }
        
        subStackView.snp.makeConstraints { make in
            make.top.equalTo(signUpBtn.snp.bottom).offset(10)
            make.centerX.equalTo(signUpBtn.snp.centerX)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-20)
        }
    }
    
    private func saveFullname(name:String, surname: String) {
        let nameRef = database.document("profile/\(emailTextfield.text!.lowercased())name")
        nameRef.setData([emailTextfield.text!.lowercased() : name])
        
        let surnameRef = database.document("profile/\(emailTextfield.text!.lowercased())surname")
        surnameRef.setData([emailTextfield.text!.lowercased() : surname])
        AppLoader.instance.hideLoaderView()
        
        self.showAlert(with: "Registration was completed succesfully", preferredStyle: .alert, actions: [(title: "Enter", style: .default)]) { (index, _) in
            if index == 0 {

                self.dismiss(animated: true)
//                FirebaseAuth.Auth.auth().signIn(withEmail: self.emailTextfield.text!.lowercased(), password: self.passwordTextfield.text!) { [weak self] result, error in
//                    guard error == nil else {
//                        self?.showAlert(with: "Unexpected error occured")
//                        AppLoader.instance.hideLoaderView()
//                        return
//                    }
//
//                    self?.dismiss(animated: true)
////                    let vc = self?.router?.tabbarViewControllers()
////                    vc?.modalPresentationStyle = .fullScreen
////                    self?.present(vc!, animated: true)
//                }
            }
        }
    }
    
    @objc func createAccount() {
        guard let email = emailTextfield.text, !email.isEmpty,
              
            let password = passwordTextfield.text, !password.isEmpty,
            let reenterPassword = reenterTextfield.text, !reenterPassword.isEmpty,
            let name = nameTextfield.text, !name.isEmpty,
            let surname = surnameTextfield.text, !surname.isEmpty else {
            self.showAlert(with: "Required fields cannot be empty")
            return
        }
        
        if password != reenterPassword {
            self.showAlert(with: "Password not matched")
        }else {
            
//            vm?.createAccount(email: email, password: password, successfulHandler: { isSuccesful in
//                if !isSuccesful {
//                    print("something gets wrong")
//                }else{
//                    print("nzm succesfull on create account")
//                }
//            })
            AppLoader.instance.showLoaderView()
            Firebase.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let _ = self else {return}
                
                guard error == nil else {
                    self?.showAlert(with: error?.localizedDescription ?? "Unexpected error occured")
                    AppLoader.instance.hideLoaderView()
                    return
                }
                self?.saveFullname(name: self?.nameTextfield.text?.lowercased() ?? "", surname: self?.surnameTextfield.text?.lowercased() ?? "")
            }
        }
    }
    
    @objc func signInClicked() {
        self.dismiss(animated: true)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        switch textField {
        case nameTextfield:
            nameTextfield.resignFirstResponder()
            surnameTextfield.becomeFirstResponder()
        case surnameTextfield:
            surnameTextfield.resignFirstResponder()
            emailTextfield.becomeFirstResponder()
        case emailTextfield:
            emailTextfield.resignFirstResponder()
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            passwordTextfield.resignFirstResponder()
            reenterTextfield.becomeFirstResponder()
        case reenterTextfield:
            reenterTextfield.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
     }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
    }
}
