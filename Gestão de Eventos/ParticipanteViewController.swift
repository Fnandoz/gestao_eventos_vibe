//
//  ParticipanteViewController.swift
//  Gestão de Eventos
//
//  Created by Fernando Gomes on 07/06/2018.
//  Copyright © 2018 lfernando. All rights reserved.
//

import UIKit
import SwiftyJSON

class ParticipanteViewController: UIViewController {
    
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var nomeparticipanteLabel: UILabel!
    @IBOutlet weak var assinaturaView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dataCadastroLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var sendMailButton: UIButton!
    
    var participante: Participante? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nomeparticipanteLabel.text = participante?.nome
        loadData(idParticipante: (participante?.id)!)
        
        infoView.layer.cornerRadius = 5
        infoView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadData(idParticipante: Int) {
        let url = URL(string: "http://receptivawebapi.azurewebsites.net/api/Participante/ObterParticipante?idParticipante=\(idParticipante)")
        
        let task = URLSession.shared.dataTask(with: url!){(data, response, erro) in
            var resultado = try? JSON(data!)
            self.participante?.email = resultado!["Email"].stringValue
            self.participante?.assinatura = resultado!["Assinatura"].stringValue
            self.participante?.DataCadastro = resultado!["DataCadastro"].stringValue
            self.participante?.Acompanhantes = resultado!["Acompanhantes"].array!
            self.participante?.status = resultado!["EstaAtiva"].boolValue
            print(resultado)
            
            DispatchQueue.main.async{
                let img = NSData(base64Encoded: (self.participante?.assinatura)!, options: [])
                self.assinaturaView.image = UIImage(data: img as! Data)
                
                self.emailLabel.text = self.participante?.email
                self.dataCadastroLabel.text = self.participante?.DataCadastro
                
                if(self.participante?.status)!{
                    self.statusLabel.text = "Ativo"
                    self.statusLabel.textColor = UIColor.green
                }else{
                    self.statusLabel.text = "Inativo"
                    self.statusLabel.textColor = UIColor.red
                }
                
                if(self.participante?.checkIn != "null"){
                    self.checkInLabel.text = self.participante?.checkIn
                }
                
                if(self.participante?.email == "null"){
                    self.sendMailButton.isHidden = true
                }
                
                
            }
        }
        task.resume()
    }
}


