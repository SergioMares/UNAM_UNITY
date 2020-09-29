using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ComportamientoAnimaciones : MonoBehaviour
{
    private Animation maniqui;
    // Start is called before the first frame update
    void Start()
    {
        //Asegurarse de que el GameObject donde se aloje este Script, tenga el 
        //componente animation para poder ejecutarse correctamente
        maniqui = GetComponent<Animation>();
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKey(KeyCode.Space))
        {
            //el método play tiene como parámetro el nombre de la animación.
            maniqui.Play("BasicMotions@Jump01 [RootMotion]");
        }
    }
}
