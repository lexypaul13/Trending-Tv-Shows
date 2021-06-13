//
//  ContactUsViewController.swift
//  Trending Tv Shows
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController , MFMailComposeViewControllerDelegate{

    @IBOutlet weak var txtBodyView: UITextView!
    @IBOutlet weak var tfSubject: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact us"
        txtBodyView.layer.borderWidth = 1.0
        txtBodyView.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }


    //MARK: IBAction Method for Button click
        @IBAction func sendEmail(_ sender: Any) {
            //TODO:  You should chack if we can send email or not
            if tfSubject.text!.isEmpty{
                self.alert(message: ErroMessage.enterSubject.rawValue, title:  ErroMessage.error.rawValue)
            }
            else if txtBodyView.text!.isEmpty{
                self.alert(message: ErroMessage.enterMessage.rawValue, title:  ErroMessage.error.rawValue)

            }
            else if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["Lexypaul14@gmail.com"])
                mail.setSubject(tfSubject.text!)
                mail.setMessageBody("<p>\(txtBodyView.text!)</p>", isHTML: true)
                present(mail, animated: true)
            } else {
                self.alert(message: ErroMessage.noEmailAPP.rawValue, title:  ErroMessage.error.rawValue)

            }
        }

        //MARK: MFMail Compose ViewController Delegate method
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }

}
