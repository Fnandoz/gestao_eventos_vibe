//
//  ViewController.swift
//  Gestão de Eventos
//
//  Created by Fernando Gomes on 05/06/2018.
//  Copyright © 2018 lfernando. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventosViewController: UITableViewController {
    var eventos: [Evento] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let url = URL(string: "http://receptivawebapi.azurewebsites.net/api/Evento/EventosAtivosDoCliente?idCliente=-1")
        let task = URLSession.shared.dataTask(with: url!){(data, response, erro) in
            var resultado = try? JSON(data)
            for i in (resultado?.array)!{
                var evento = Evento(
                    id: i["Id"].int!, nome: i["Nome"].string!,
                    imagem: i["Imagem"].string!, clienteImagem: i["ClienteImagem"].string!,
                    inicio: i["Inicio"].string!,
                    quando: i["Quando"].string!,
                    local: i["Local"].string!)
                self.eventos.append(evento)
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }   
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventoCell")
        let evento = eventos[indexPath.row]
        cell?.textLabel?.text = evento.nome
        
        return cell!

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evento = eventos[indexPath.row]
        let eventoController = storyboard?.instantiateViewController(withIdentifier: "evento") as! EventoViewController
        
        eventoController.evento = evento
        
        navigationController?.pushViewController(eventoController, animated: true)
    }

}



