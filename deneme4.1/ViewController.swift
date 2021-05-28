//
//  ViewController.swift
//  deneme4.1
//
//  Created by erdem öden on 6.04.2021.
//  Copyright © 2021 erdem öden. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UIScrollViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{

    @IBOutlet weak var lblisim: UILabel!
    @IBOutlet weak var lblsoyisim: UILabel!
    @IBOutlet weak var txtisim: UITextField!
    @IBOutlet weak var txtsoyisim: UITextField!
    @IBOutlet weak var kayitbut: UIButton!
    @IBOutlet weak var secimage: UIImageView!
    @IBOutlet weak var haritasegue: UIButton!
    @IBOutlet weak var secilimage: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var benimview: UIView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //self.scroll.setNeedsLayout();
        //self.scroll.layoutIfNeeded();
        secimage.isUserInteractionEnabled = true;
        let gesture = UITapGestureRecognizer(target: self, action: #selector(deneme))
        secimage.addGestureRecognizer(gesture);
        overrideUserInterfaceStyle = .light
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuac))
        overrideUserInterfaceStyle = .light
    }
    override func viewDidAppear(_ animated: Bool) {
        self.scroll.delegate = self;
        //self.scroll.setNeedsLayout();
        //self.scroll.layoutIfNeeded();
        let width = view.frame.size.width;
        let height = view.frame.size.height;
        //let widthnew = view.frame.size.width/2;
        self.scroll.frame = CGRect(x:0, y: 0, width: width, height: height);
        scroll.contentSize = CGSize(width:width+width/2, height:0);
        scroll.contentOffset.x = width/2;
        //hersey.frame = CGRect(x:0, y: 0, width:width+width/2, height: height);
        benimview.frame = CGRect(x:0, y: 0, width: width/2, height: height);
        kayitbut.frame = CGRect(x:width+width/2-(width+width/2)*20/100,y: height*10/100, width: (width+width/2)*20/100, height: height*15/100);
        lblisim.frame = CGRect(x:width/2+5, y: height*12/100, width: (width+width/2)*10/100, height: lblisim.frame.height);
        txtisim.frame = CGRect(x:width/2+(width+width/2)*10/100,y: height*12/100, width: width+width/2-(width+width/2)*65/100, height: txtisim.frame.height);
        lblsoyisim.frame = CGRect(x:width/2+5, y: height*20/100, width:(width+width/2)*20/100, height: lblsoyisim.frame.height);
        txtsoyisim.frame = CGRect(x:width/2+(width+width/2)*10/100, y: height*20/100, width:(width+width/2)-(width+width/2)*65/100, height: txtsoyisim.frame.height);
        secilimage.frame = CGRect(x:(width/2)*2-((width+width/2)*50/100)/2, y: height*30/100, width: (width+width/2)*50/100, height: height*30/100);
        secimage.frame = CGRect(x:width+width/2-(width+width/2)*9/100, y: height*50/100-height*10/100, width: (width+width/2)*10/100, height: height*10/100);
        haritasegue.frame = CGRect(x: width-haritasegue.frame.width/2, y: height*60/100, width: haritasegue.frame.width, height: haritasegue.frame.height);
        button1.frame = CGRect(x: width/4-width/4, y: height*15/100, width: width/2, height: button1.frame.height);
        button2.frame = CGRect(x: width/4-width/4, y: height*30/100, width: width/2, height: button1.frame.height);
        button3.frame = CGRect(x: width/4-width/4, y: height*45/100, width: width/2, height: button1.frame.height);
        
    }
    @objc func deneme(){
        let picker = UIImagePickerController();
        picker.delegate = self;
        picker.sourceType = .photoLibrary;
        self.present(picker, animated: true, completion: nil);
        
    }
    @objc func menuac(){
        scroll.setContentOffset(CGPoint(x:0, y:scroll.contentOffset.y), animated: true);
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        secilimage.image = info[.originalImage] as? UIImage;
        picker.dismiss(animated: true, completion: nil);
    }
    @IBAction func alertharita(_ sender: Any) {
        let alert = UIAlertController(title: "Yapılacak", message: "Haritalar ile ilgili çalışma yapılıp güncellenecek", preferredStyle: .alert);
        let button = UIAlertAction(title: "Tamam", style: .default, handler: nil);
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil);
    }
    @IBAction func button3ac(_ sender: Any) {
        let alert = UIAlertController(title: "Yapılacak", message: "buttonlara özellik verilecek", preferredStyle: .alert);
        let button = UIAlertAction(title: "Tamam", style: .default, handler: nil);
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil);

    }
    @IBAction func button2ac(_ sender: Any) {
        let alert = UIAlertController(title: "Yapılacak", message: "buttonlara özellik verilecek", preferredStyle: .alert);
        let button = UIAlertAction(title: "Tamam", style: .default, handler: nil);
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil);
    }
    @IBAction func button1ac(_ sender: Any) {
        let alert = UIAlertController(title: "Yapılacak", message: "buttonlara özellik verilecek", preferredStyle: .alert);
        let button = UIAlertAction(title: "Tamam", style: .default, handler: nil);
        alert.addAction(button)
        self.present(alert, animated: true, completion: nil);
    }
    @IBAction func kayit(_ sender: Any) {
        if(txtisim.text!.isEmpty && txtsoyisim.text!.isEmpty){
            performSegue(withIdentifier: "totable", sender: nil)
        }
        else{
        let appdelegate = UIApplication.shared.delegate as! AppDelegate;
        let context = appdelegate.persistentContainer.viewContext;
        let entity = NSEntityDescription.insertNewObject(forEntityName:"Kullanici", into: context);
        entity.setValue(UUID(), forKey: "uuid");
        entity.setValue(txtisim.text!, forKey: "isim");
        entity.setValue(txtsoyisim.text!, forKey: "soyisim");
        do{
            try context.save();
            performSegue(withIdentifier: "totable", sender: nil)
        }
        catch{
            print("hata");
        }
        }
        
    }
    
    

}

