//
//  tables.swift
//  deneme4.1
//
//  Created by erdem öden on 3.05.2021.
//  Copyright © 2021 erdem öden. All rights reserved.
//

import UIKit
import CoreData
class tables: UIViewController, UITableViewDelegate , UITableViewDataSource{
    var isim = [String]();
    var soyisim = [String]();
    var id = [UUID]();
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isim.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(isim[indexPath.row]+soyisim[indexPath.row])"
        return cell
    }
    
    @IBOutlet weak var tablo: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        tablo.delegate = self;
        tablo.dataSource = self;
        let appdelegate = UIApplication.shared.delegate as!AppDelegate;
        let context = appdelegate.persistentContainer.viewContext;
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Kullanici");
        do{
            let items = try context.fetch(fetch);
            for item in items as! [NSManagedObject]{
                if let name = item.value(forKey: "isim") as? String{
                    isim.append(name)
                }
                if let surname = item.value(forKey: "soyisim")as? String{
                    soyisim.append(surname)
                    
                }
                id.append(item.value(forKey: "uuid") as! UUID)
            }
            tablo.reloadData();
        }
        catch{
            print("Something is Wrong");
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appdelegate = UIApplication.shared.delegate as! AppDelegate;
            let context = appdelegate.persistentContainer.viewContext;
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Kullanici");
            fetch.predicate = NSPredicate(format: "uuid = %@", id[indexPath.row].uuidString)
            do{
                let sil = try context.fetch(fetch)
                for eleman in sil as! [NSManagedObject]{
                    context.delete(eleman);
                    do{
                        try context.save()
                        
                    }
                    catch{
                        print("Hata");
                    }
                    
                }
            }
            catch{
                print("Hata");
            }
           
            isim.remove(at: indexPath.row);
            soyisim.remove(at: indexPath.row);
            id.remove(at: indexPath.row);
            tablo.reloadData();
        }
    }
        // Do any additional setup after loading the view.
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

