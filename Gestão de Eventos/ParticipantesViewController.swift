//
//  ParticipanteViewController.swift
//  Gestão de Eventos
//
//  Created by Fernando Gomes on 05/06/2018.
//  Copyright © 2018 lfernando. All rights reserved.
//

import UIKit
import SwiftyJSON

class ParticipantesViewController: UITableViewController {
    var participantes: [Participante] = []
    var evento: Evento? = nil
    var baseUrl = String()
    let threshold = 100.0
    var carregando = false
    var paginaAtual = 1
    
    @IBOutlet weak var tituloItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tituloItem.title = evento?.nome
        baseUrl = "http://receptivawebapi.azurewebsites.net/api/Evento/ParticipantesDoEvento?idEvento=\(evento?.id ?? 0)"
        loadData(page: paginaAtual)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participantes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantesCell") as! participantesCell
        let participante = participantes[indexPath.row]
        
        cell.nomeLabel.text = participante.nome
        if (participante.checkIn == "null") {
            cell.checkInStatus.image = #imageLiteral(resourceName: "reddot")
        }else{
            cell.checkInStatus.image = #imageLiteral(resourceName: "greendot")
        }
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let participante = participantes[indexPath.row]
        let participanteController = storyboard?.instantiateViewController(withIdentifier: "participante") as! ParticipanteViewController
    
        participanteController.participante = participante
        navigationController?.pushViewController(participanteController, animated: true)
    }
    
    func loadData(page: Int) {
        let url = URL(string: baseUrl)
        var json = [String:Any]()
    
        json["Pagina"] = page
        json["RegistrosPorPagina"] = 15
        
        do {
            carregando = true
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request){(data, response, erro) in
                //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
                var resultado = try? JSON(data as Any)
                //print(resultado!["Lista"])
                for i in (resultado!["Lista"].array)!{
                    let participante = Participante(id: i["Id"].int!, nome: i["Nome"].string!, checkIn: i["CheckIn"].rawString()!)
                    self.participantes.append(participante)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
        } catch  {
            
        }
        self.carregando = false
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if(!self.carregando && (maximumOffset - contentOffset) <= CGFloat(self.threshold)){
            self.carregando = true
            loadData(page: paginaAtual+1)
        }
        
    }
    
}

class participantesCell: UITableViewCell {
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var checkInStatus: UIImageView!
    
}
