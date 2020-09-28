using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SonidoCarro : MonoBehaviour
{
    //Sonidos del carro 
    public AudioSource audioEncender;
    public AudioSource audioAcelerar;
    // Start is called before the first frame update
    void Start()
    {
        audioEncender.Play(0);
    }

    // Update is called once per frame
    void Update()
    {
        SonidoAcel();
    }

    void SonidoAcel()
    {
        if (Input.GetKeyDown(KeyCode.UpArrow))
        {
            if (!audioAcelerar.isPlaying)
            {
                audioAcelerar.Play();
                Debug.Log("acelerando Audio");
            }
        }

        if (Input.GetKeyUp(KeyCode.UpArrow))
        {
            audioAcelerar.Stop();
            Debug.Log("Parar Audio");
        }

    }
}
