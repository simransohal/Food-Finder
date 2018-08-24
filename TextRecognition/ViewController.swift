
//Simran Sohal

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    
    
    @IBOutlet weak var userFoodField: UITextField!
    @IBOutlet weak var foodSafetyLabel: UILabel!
    let imagePicker = UIImagePickerController()
    var ingredients = "";
    var ingredientFound = false;
    var tgtIngredient = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = UIImage(named: "204")?.g8_blackAndWhite()
            tesseract.recognize()
            
            ingredients = tesseract.recognizedText
            
            userFoodField.delegate = self
            
        }
        
        
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func enterTapped(_ sender: Any) {
        tgtIngredient = userFoodField.text!
        ingredientFound = ingredients.containsIgnoringCase(find: tgtIngredient)
        updateUI()
    }
    
    func updateUI() {
        if ingredientFound {
            view.backgroundColor = .red
            foodSafetyLabel.text = "\(tgtIngredient) is found"
        } else {
            view.backgroundColor = .green
            foodSafetyLabel.text = "\(tgtIngredient) is not found"
        }
    }

}

extension String {
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

        
    



    
}

