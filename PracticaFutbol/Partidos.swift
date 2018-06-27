//
//  Jugadores.swift
//  PracticaFutbol
//
//  Created by Javier on 20/12/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import UIKit

class Partidos: UITableViewController {

    let matchesTodayCell : TableViewCell? = nil
    
    var images2 = [String:UIImage]()
    var matchesToday = [[String:Any]]()
    
    var imagesL = [String:UIImage]()
    
    var images1 = [String:UIImage]()
    
    var dia : String = ""
    
    fileprivate let futbolURL = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=f20584c1890881a649b78a5efef840fb&tz=Europe/Madrid&format=json&"
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFecha()
        descargaPartidos()
        self.title = "Hoy juegan: "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func descargaPartidos() {
        let query = "req=matchsday&top=1"
        let url1 = "\(futbolURL)\(query)"
        
        let url = URL(string: url1)
        
        let queue = DispatchQueue(label: "Descargando")
        queue.async {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
            defer {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            let task = self.session.downloadTask(with: url!){( location: URL?,
                response: URLResponse?,
                error: Error?) in
                if error == nil && (response as! HTTPURLResponse).statusCode == 200 {
                    if let data = try? Data(contentsOf: url!){
                        do {
                            if let diccionario = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String:Any] {
                                
                                if let diccionario2 = diccionario["matches"] as? [[String:Any]]{
                                    print(diccionario2)
                                    self.matchesToday = diccionario2
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }catch let err  {
                            print("Fallo")                       }
                    }else {
                        print("Fallo")
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchesToday.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchescell", for: indexPath)
        
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        

         let variable = self.matchesToday[indexPath.row]

        if let nombre1 = variable["local"] as? String{
            
            if let nombre2 = variable["visitor"] as? String{
                  cell.textLabel?.text = nombre1 + "-" + nombre2
            }
       }
           if let hora = variable["hour"] as? String{
              if let minutos = variable["minute"] as? String{
                 cell.detailTextLabel?.text = "\(hora):\(minutos)"
          }
       }
//        if let liga = variable["competition_name"] as? String{
//            cell?.liga?.text = liga
//        }
//        if let imagen1Url = variable["local_shield"] as? String {
//            if let escudo1 = self.images1[imagen1Url] {
//                cell?.imagen1.image = escudo1
//            } else {
//                if let URL1 = URL(string: imagen1Url){
//                    if let data = try? Data(contentsOf: URL1){
//                        if let image1 = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                
//                                self.images1[imagen1Url] = image1
//                                
//                                self.tableView.reloadRows(at: [indexPath], with: .fade)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        if let imagen2Url = variable["visitor_shield"] as? String {
//            if let escudo2 = self.images2[imagen2Url] {
//                cell?.imagen2.image = escudo2
//            } else {
//                if let URL2 = URL(string: imagen2Url){
//                    if let data = try? Data(contentsOf: URL2){
//                        if let image2 = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                self.images2[imagen2Url] = image2
//                               
//                                self.tableView.reloadRows(at: [indexPath], with: .fade)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
        return cell
    }
    
    func getFecha(){
        let date = Date()
        let calendar = Calendar.current
        let mes = calendar.component(.month, from: date)
        let dia = calendar.component(.day, from: date)
        let año = calendar.component(.year, from: date)
        print("fecha = \(dia)-\(mes)-\(año)")
        self.dia = "\(año)/\(mes)/\(dia)"
}
}
