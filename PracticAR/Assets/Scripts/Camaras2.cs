using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Camaras2 : MonoBehaviour
{
    public GameObject target;
    // Start is called before the first frame update
    void Start()
    {
        
    }


    void Update()
    {
        // Rota la cámara alrededor del GameObject target a 20 grados por segundo.
        transform.RotateAround(target.transform.position, Vector3.up, 20 * Time.deltaTime);

        // Rota la cámara en direción del objeto target
        transform.LookAt(target.transform);

        // Rota la camara en su propio eje
        //transform.LookAt(target.transform, Vector3.right);
    }
}
