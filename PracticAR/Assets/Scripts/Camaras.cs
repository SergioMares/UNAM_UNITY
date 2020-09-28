using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Camaras : MonoBehaviour
{

    public Camera camara1;
    public Camera camara2;

    public Camera camara3;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey("1"))
        {
            camara3.enabled = false; camara2.enabled = false; camara1.enabled = true;
        }
        if (Input.GetKey("2"))
        {
            camara3.enabled = false; camara1.enabled = false; camara2.enabled = true;
        }
        if (Input.GetKey("3"))
        {
            camara2.enabled = false; camara1.enabled = false; camara3.enabled = true;
        }
    }
}
