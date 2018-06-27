//
//  Competiciones.swift
//  PracticaFutbol
//
//  Created by Javier on 20/12/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import UIKit

class Competiciones: UITableViewController {
    
    let URL_pagina="http://apiclient.resultados-futbol.com/scripts/api/api.php?key=f20584c1890881a649b78a5efef840fb&tz=Europe/Madrid&format=json&req=leagues&top=1&year=2014"
    
    var variable: String!
    var prueba = [[String:AnyObject]]()
    var escudetto: String!
    var idLeague = [String:AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        downloadCompeticiones()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueEquipos" {
            
            if let equiposdentro1 = segue.destination as? Equipos {
                
                if let ip = tableView.indexPathForSelectedRow{
                    if let dic = prueba[ip.row]["id"] as? String{
                        equiposdentro1.idLeague = dic
                    }
                    
                }
            }
        }
    }
    
    
    private func downloadCompeticiones(){
        if let url1 = URL(string: URL_pagina){
            if let data = try? Data(contentsOf: url1){
                if let dic = (try? JSONSerialization.jsonObject(with: data)) as? [String:AnyObject]{
                    if let competis = dic["league"] as? [[String:AnyObject]]{
                        self.prueba = competis
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
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return prueba.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seguecompetis", for: indexPath)
        
        cell.textLabel?.text=""
        cell.detailTextLabel?.text=""
        cell.imageView?.image=nil
        
        if let name = prueba[indexPath.row]["name"] as? String{
            cell.textLabel?.text = name
            print(name)
        }
        if let estampita = prueba[indexPath.row]["logo"] as? String {
            self.escudetto=estampita
            cell.imageView?.image = getIconNamed(escudetto)
            
        }
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
