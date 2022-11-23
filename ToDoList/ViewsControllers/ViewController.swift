//
//  ViewController.swift
//  ToDoList
//
//  Created by Alumno on 19/10/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tablaJugador: UITableView!
    
    var listaJugador = [Jugador]()
    
    //Referencia al coredata
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaJugador.delegate = self
        tablaJugador.dataSource = self
        leerJugadores()
    } 
 
    
    @IBAction func nuevaTarea(_ sender: UIBarButtonItem) {
        var nombreJugador = UITextField()
        var dorsal = UITextField()

        
        let alerta = UIAlertController(title: "Amsterdam", message: "Nuevo Jugador", preferredStyle: .alert)
        
        let accionAceptar = UIAlertAction(title: "Agregar", style: .default) { (_) in
            let nuevaTarea = Jugador(context: self.contexto)
            nuevaTarea.nombre = nombreJugador.text
            nuevaTarea.dorsal = dorsal.text
            
            self.listaJugador.append(nuevaTarea)
            
            self.guardar()
        }
        
        alerta.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "Nombre completo..."
            nombreJugador =  textFieldAlert
        }
        alerta.addTextField { textFieldAlert in
            textFieldAlert.placeholder = "Dorsal..."
            dorsal =  textFieldAlert
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
        self.tablaJugador.reloadData()
    }
    
    //lee las tareas
    func leerJugadores(){
        let solicitud : NSFetchRequest<Jugador> = Jugador.fetchRequest()
        
        do {
            listaJugador = try contexto.fetch(solicitud)
        } catch{
            print(error.localizedDescription)
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaJugador.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaJugador.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
    
        
        let  jugador = listaJugador[indexPath.row]
        //Operadores ternearios
        //pone los valores de la tarea en la tabla
        celda.detailTextLabel?.text = jugador.dorsal
        celda.textLabel?.text = jugador.nombre

        /*pone de color la tarea depende si esa hecha o no
        celda.textLabel?.textColor = tarea.realizada ? .black : .blue
        
        celda.detailTextLabel?.text = tarea.realizada ? "Completada" : "Por completar"
        
        //marcar tareas completadas
        celda.accessoryType = tarea.realizada ? .checkmark : .none
        */
        return celda
    }
    
    /*Tabla para poner una paloma a la tarea realizada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Palomar la tarea
        if tablaTareas.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tablaTareas.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tablaTareas.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        //Editar en coredata
        listaTareas[indexPath.row].realizada = !listaTareas[indexPath.row].realizada
        
        guardar()
        
        //deselecciona la tarea
        tablaTareas.deselectRow(at: indexPath, animated: true)
    }
 */
    
    //Tabla para eliminar las tareas
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionEliminar = UIContextualAction(style: .normal, title: "Eliminar") { _,_,_  in
            self.contexto.delete(self.listaJugador[indexPath.row])
            self.listaJugador.remove(at: indexPath.row)
            self.guardar()
        }
        accionEliminar.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
    
     
}

