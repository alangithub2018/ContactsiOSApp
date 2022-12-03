//
//  DetallesViewController.swift
//  Contact
//
//  Created by MacBookAir on 01/12/22.
//

import UIKit

class DetallesViewController: UIViewController {
    
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var detailNameLabel : UILabel!
    @IBOutlet weak var detailEmailLabel : UILabel!
    @IBOutlet weak var detailTelefonoLabel : UILabel!
    @IBOutlet var detailRfcText: UILabel!
    @IBOutlet var detailEdadText: UILabel!
    @IBOutlet var detailDobText: UILabel!
    @IBOutlet var detailGenderText: UILabel!
    @IBOutlet var detailDegreeText: UILabel!
    
    var imgProfile = UIImage()
    var detailName = ""
    var detailEmail = ""
    var detailTelefono = ""
    var detailRfc = ""
    var detailEdad = 0
    var detailDob = ""
    var detailGender = ""
    var detailDegree = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        portraitImageView.image = imgProfile
        detailNameLabel.text = detailName
        detailEmailLabel.text = detailEmail
        detailTelefonoLabel.text = detailTelefono
        detailRfcText.text = detailRfc
        detailEdadText.text = String(detailEdad)
        detailDobText.text = detailDob
        detailGenderText.text = detailGender
        detailDegreeText.text = detailDegree
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
