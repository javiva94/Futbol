//
//  Equipos.swift
//  PracticaFutbol
//
//  Created by Javier on 20/12/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import UIKit

class Equipos: UITableViewController {
    
    var idLeague: String!
    var prueba2 = [[String:AnyObject]]()
    var escudetto: String!
    var orl: String!
    
    let URL_pagina = "http://apiclient.resultados-futbol.com/scripts/api/api.php?key=f20584c1890881a649b78a5efef840fb&tz=Europe/Madrid&format=json&req=teams&"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let cacho = "league=\(idLeague!)"
        if let montaje = cacho.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            let urlfinal = "\(URL_pagina)\(montaje)"
            self.orl = urlfinal
            print(orl)
        }
         //orl = "\(URL_pagina)\(cacho)"
        
        downloadEquipos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return prueba2.count
    }
    
    
    private func downloadEquipos(){
        print(orl)
        if let url2 = URL(string: orl){
            if let data = try? Data(contentsOf: url2){
                if let dic = (try? JSONSerialization.jsonObject(with: data)) as? [String:AnyObject]{
                    if let equipis = dic["team"] as? [[String:AnyObject]]{
                        self.prueba2 = equipis
                    }
                    else{
                        print("FALLO")
                    }
                }
                else{
                    print("FALLO2")
                }
            }
        }
    }
    
    fileprivate func getIconNamed(_ name: String) -> UIImage? {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        defer {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        if let estampita = escudetto as? String {
            guard let url = URL(string: "\(estampita)") else {
                print("Error: URL mal formada")
                return nil
            }
            
            guard let data = try? Data(contentsOf: url) else {
                print("Error: no se han podido descargar el icono.")
                return nil
            }
            
            guard let img = UIImage(data: data) else {
                print("Los datos recibidos no tienen un formato inesperado.")
                return nil
            }
            
            return img
        }
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Equipos_cell", for: indexPath)
        
        
        cell.textLabel?.text=""
        cell.detailTextLabel?.text=""
        cell.imageView?.image=nil
        
        if let name = prueba2[indexPath.row]["nameShow"] as? String{
            cell.textLabel?.text = name
            print(name)
        }
        if let estampita = prueba2[indexPath.row]["shield"] as? String {
            self.escudetto=estampita
            cell.imageView?.image = getIconNamed(escudetto)
            
        }
        return cell
    }
    
    
        }

    
    
    

    
