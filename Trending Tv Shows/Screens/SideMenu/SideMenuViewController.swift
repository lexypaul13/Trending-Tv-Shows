//
//  SideMenuViewController
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/6/21.
//

import UIKit
import SafariServices

class SideMenuViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    //MARK:- UIActions
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
   
    
    @IBAction func homeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: {
        })
    }
    
    @IBAction func aboutTapped(_ sender: Any) {
        let viewController = AboutUsViewController(nibName: String(describing: AboutUsViewController.self), bundle: nil)
        viewController.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func termsAndConditionTapped(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: "https://www.themoviedb.org/terms-of-use")!)
        present(svc, animated: true, completion: nil)
    }
    
    @IBAction func rateUsTapped(_ sender: Any) {
        let viewController = ContactUsViewController(nibName: String(describing: ContactUsViewController.self), bundle: nil)
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
