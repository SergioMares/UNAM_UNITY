using UnityEngine;
public class test2 : MonoBehaviour
{
    public class Alumno
    {        
        public int matricula;
        public string nombre;
        public int calificacion;
        public string carrera;
        public bool estado;

        //constructor -> siempre es el nombre de la clase. 
        //no regresan valores ni son void
        public Alumno()
        {
            matricula = 0000;
            nombre = "sin nombre";
            calificacion = 0;
            carrera = "sin carrera";
        }

        public Alumno(int initMatricula, string initNombre, int initCalificacion, string initCarrera)
        {
            matricula = initMatricula;
            nombre = initNombre;
            calificacion = initCalificacion;
            carrera = initCarrera;
        }        

        public Alumno(int initMatricula, bool initEstado)
        {
            matricula = initMatricula;
            estado = initEstado;
            if (estado)
                calificacion = 10;
        }
    }

    //crear una instancia (objeto) de la clase alumno
    public Alumno alumno1 = new Alumno(); //encaja con constructor1
    public Alumno alumno2 = new Alumno(268221, "Sergio Mares", 9, "INC11"); // encaja con constructor 2
    public Alumno alumno3 = new Alumno(234554, true); //encaja con constructor 3 

    public void mostrarDatos()
    {
        Debug.Log("alumno3  nombre = " + alumno2.nombre);
        alumno2.nombre = "Luis Peña";
        Debug.Log("alumno3  nombre = " + alumno2.nombre);
    }
    


}

