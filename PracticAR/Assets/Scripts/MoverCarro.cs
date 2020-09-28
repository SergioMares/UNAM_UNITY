using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoverCarro : MonoBehaviour
{
    //Banderas touch
    public bool tIzq_flag = false;
    public bool tDer_flag = false;

    // Bandera para indicar si el coche se moverá de forma automática o controlado
    public bool controlado_flag = false;

    //Se llaman e inicializan los gameObjects con las ruedas del coche

    public GameObject neumatico1;
    public GameObject neumatico2;
    public GameObject neumatico3;
    public GameObject neumatico4;

    bool acel_flag = false;
    bool dir_flag = false;

    //velocidad máxima del coche
    public float velocidadMax = 1500.0f;

    //Incremento en el giro
    public float IncGiroVolante = 90.0f;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (controlado_flag == true)
        { 
            //Control Teclado
            Acelerar();
            GirarRuedas();
            giroVolante(acel_flag, dir_flag);

            //Control touch
            AcelerarTouch();
        }
        else
        {
            Acelerar();
            GirarRuedas();
        }

        

    }

    //Función para girar las rudas hacia adelante y hacia atrás
    void GirarRuedas()
    {
        if (controlado_flag == true)
        {
            if (Input.GetKey(KeyCode.UpArrow))
            {
                neumatico1.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico2.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
                neumatico3.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico4.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
            }
            if (Input.GetKey(KeyCode.DownArrow))
            {
                neumatico1.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
                neumatico2.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico3.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
                neumatico4.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
            }
        }
        else
        {
            neumatico1.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
            neumatico2.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
            neumatico3.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
            neumatico4.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
        }
    }

    // Función para mover el coche hacia adelante y atrás
    void Acelerar()
    {
        if (controlado_flag == true)
        {
            if (Input.GetKey(KeyCode.UpArrow))
            {
                transform.Translate(Vector3.forward * (velocidadMax / 100) * Time.deltaTime);
                acel_flag = true;
                dir_flag = true;

            }
            else if (Input.GetKey(KeyCode.DownArrow))
            {
                transform.Translate(Vector3.back * (velocidadMax / 100) * Time.deltaTime);
                acel_flag = true;
                dir_flag = false;

            }
            else
            {
                acel_flag = false;
            }
        }
        else
        {
            transform.Translate(Vector3.forward * (velocidadMax / 200) * Time.deltaTime);
            acel_flag = true;
            dir_flag = true;
        }
    }

    //Función para girar el coche
    void giroVolante(bool acel, bool dir)
    {
        if (dir == true)
        {// Dirección hacia adelante
            if (Input.GetKey(KeyCode.LeftArrow) && acel == true)
            {
                transform.Rotate(Vector3.down, IncGiroVolante * Time.deltaTime);
            }

            if (Input.GetKey(KeyCode.RightArrow) && acel == true)
            {
                transform.Rotate(Vector3.up, IncGiroVolante * Time.deltaTime);
            }
        }
        if (dir == false)
        {// Dirección hacia atrás
            if (Input.GetKey(KeyCode.LeftArrow) && acel == true)
            {
                transform.Rotate(Vector3.up, IncGiroVolante * Time.deltaTime);
            }

            if (Input.GetKey(KeyCode.RightArrow) && acel == true)
            {
                transform.Rotate(Vector3.down, IncGiroVolante * Time.deltaTime);
            }
        }
    }

    void AcelerarTouch()
    {

            if (tIzq_flag == true && tDer_flag == true)
            {
                transform.Translate(Vector3.forward * (velocidadMax / 100) * Time.deltaTime);

                neumatico1.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico2.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
                neumatico3.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico4.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
            }
            else if (tIzq_flag == true && tDer_flag == false)
            {
                transform.Rotate(Vector3.down, IncGiroVolante * Time.deltaTime);
                transform.Translate(Vector3.forward * (velocidadMax / 100) * Time.deltaTime);

                neumatico1.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico2.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
                neumatico3.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico4.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
            }
            else if (tIzq_flag == false && tDer_flag == true)
            {
                transform.Rotate(Vector3.up, IncGiroVolante * Time.deltaTime);
                transform.Translate(Vector3.forward * (velocidadMax / 100) * Time.deltaTime);

                neumatico1.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico2.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
                neumatico3.transform.Rotate(Vector3.left, velocidadMax * Time.deltaTime);
                neumatico4.transform.Rotate(Vector3.right, velocidadMax * Time.deltaTime);
           }
        
    }
    
    public void TouchIzq()
    {
        tIzq_flag = true;
        
    }

    public void NoTouchIzq()
    {
        tIzq_flag = false;
        
    }
    public void TouchDer()
    {
        tDer_flag = true;
    }

    public void NoTouchDer()
    {
        tDer_flag = false;
    }
    
}
