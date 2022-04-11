import UIKit

    class LoginFormController: UIViewController {
        
        @IBOutlet weak var scrollView: UIScrollView!
        
        @IBOutlet weak var passworfTextField: UITextField!
        
        @IBOutlet weak var loginTextField: UITextField!
       
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideScreen))
            view.addGestureRecognizer(tapGR)
        }
        
        @objc func hideScreen() {
            view.endEditing(true)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        @objc func willShowKeyboard(_ notification: Notification) {
            guard let info = notification.userInfo as NSDictionary?,
                  let keyboardsize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {return}
            
            let keyBoardHeight = keyboardsize.cgRectValue.size.height
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardHeight, right: 0)
        }
        
        @objc func willHideKeyboard(_ notification: Notification) {
            guard let info = notification.userInfo as NSDictionary?,
                  let keyboardsize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {return}
            
            let keyBoardHeight = keyboardsize.cgRectValue.size.height
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -keyBoardHeight, right: 0)
        }
        
        @IBAction func tapButtonLogIn(_ sender: Any) {
            guard let login = loginTextField.text,
                  let password = passworfTextField.text,
                    login == "",
                    password == "" else {
                    show(message: "Неправильный логин или пароль !")
                    return
                  }
            
            performSegue(withIdentifier: "Log in", sender: nil)
        }
    }
