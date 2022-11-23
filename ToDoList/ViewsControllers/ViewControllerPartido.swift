//
//  ViewControllerPartido.swift
//  ToDoList
//
//  Created by Alumno on 22/11/22.
//

import UIKit
import CoreData

class ViewControllerPartido: UIViewController {

    @IBOutlet weak var tablaPartido: UITableView!
    
    var listaPartido = [Partidos]()
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaPartido.delegate = self
        tablaPartido.dataSource = self
        

    }
    

   
    @IBAction func nuevoPartido(_ sender: Any) {
        
        var nombreEquipo = UITextField()
        var golesAFavor = UITextField()
        var golesEnContra = UITextField()


        
        let alerta = UIAlertController(title: "Amsterdam", message: "Nuevo Jugador", preferredStyle: .alert)
        
        let accionAceptar = UIAlertAction(title: "Agregar", style: .default) { (_) in
            let nuevaTarea = Partidos(context: self.contexto)
            nuevaTarea.equipoRival = nombreEquipo.text
            nuevaTarea.golesFavor = golesAFavor.text
            nuevaTarea.golesContra = golesEnContra.text
            
            
            self.listaPartido.append(nuevaTarea)
            
            self.guardar()
        }
        
        alerta.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "Nombre equipo rival..."
            nombreEquipo =  textFieldAlert
        }
        alerta.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "Goles a favor..."
            golesAFavor =  textFieldAlert
        }
        alerta.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "Goles en contra..."
            golesEnContra =  textFieldAlert
        }
        alerta.addAction(accionAceptar)
        
        present(alerta,animated: true)
        
    }
    
    //Guarda/actualiza la tabla
    func guardar(){
        do {
            try contexto.save()
        }catch{
            print(error.localizedDescription)
        }
        self.tablaPartido.reloadData()
    }
    
    //lee las tareas
    func leerJugadores(){
        let solicitud : NSFetchRequest<Partidos> = Partidos.fetchRequest()
        
        do {
            listaPartido = try contexto.fetch(solicitud)
        } catch{
            print(error.localizedDescription)
        }
    }
    
}

extension ViewControllerPartido: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
