//
//  ViewController.swift
//  task2RecursosWeb
//
//  Created by Julio Ahuactzin on 16/04/16.
//  Copyright © 2016 Julio Ahuactzin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbnTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titleLabel.text = ""
        authorLabel.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func isbnAction(sender: UITextField){
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        getData()
        return true
    }
    
    func getData(){
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        if isbnTextField.text != ""{
            let url = NSURL(string: urls + isbnTextField.text!)
            let datos = NSData(contentsOfURL: url!)
            do{
                if let response:NSDictionary = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves) as? NSDictionary{
                    if response.count > 0 {
                        let dic1 = response
                        let isbn = "ISBN:\(isbnTextField.text!)"
                        let dic2 = dic1["\(isbn)"] as! NSDictionary
                        self.titleLabel.text = "Titulo del libro: \(dic2["title"] as! NSString as String)"
                        let dic3 = dic2["authors"] as! NSArray
                        self.authorLabel.text = "Autores: \(dic3[0]["name"] as! NSString as String)"
                        if dic2["cover"] != nil{
                            let dic4 = dic2["cover"] as! NSDictionary
                            let urlImage = NSURL(string: dic4["medium"] as! NSString as String)
                            let data = NSData(contentsOfURL: urlImage!)
                            frontImageView.image = UIImage(data: data!)
                        }else{
                            let urlImage = NSURL(string: "http://forestsclearance.nic.in/images/no-image-available.jpg.gif")
                            let data = NSData(contentsOfURL: urlImage!)
                            frontImageView.image = UIImage(data: data!)
                        }
                        
                    }else{
                        //adding a loading alert
                        let alert = UIAlertController(title: "Atención", message: "Ingresa un ISBN correcto.", preferredStyle: .Alert)
                        
                        alert.view.tintColor = UIColor.blackColor()
                        let accionOK = UIAlertAction(title: "OK", style: .Default, handler:{
                            accion in
                        })
                        alert.addAction(accionOK)
                        self.presentViewController(alert, animated: true, completion: nil)
                        ///////////////////////

                    }
                }else{
                    //adding a loading alert
                    let alert = UIAlertController(title: "Atención", message: "Existe un error en la petición al servidor.", preferredStyle: .Alert)
                    
                    alert.view.tintColor = UIColor.blackColor()
                    let accionOK = UIAlertAction(title: "OK", style: .Default, handler:{
                        accion in
                    })
                    alert.addAction(accionOK)
                    self.presentViewController(alert, animated: true, completion: nil)
                    ///////////////////////

                }
               
                
            } catch _{
                
            }
            
        }else{
            //adding a loading alert
            let alert = UIAlertController(title: "Atención", message: "Ingresa un numero ISBN.", preferredStyle: .Alert)
            
            alert.view.tintColor = UIColor.blackColor()
            let accionOK = UIAlertAction(title: "OK", style: .Default, handler:{
                accion in
            })
            alert.addAction(accionOK)
            self.presentViewController(alert, animated: true, completion: nil)
            ///////////////////////

        }
        
    }

}

