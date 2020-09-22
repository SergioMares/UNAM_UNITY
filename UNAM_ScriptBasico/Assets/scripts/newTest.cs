using System.Collections.Generic;
using UnityEngine;

public class newTest : MonoBehaviour
{
    //Dictionary<generic1, generic2> nombreDiccionario = 
    //    new Dictionary<generic1, generic2>();
    Dictionary<string, string> traductor = 
        new Dictionary<string, string>();

    // Start is called before the first frame update
    void Start()
    {
        traductor.Add("Hola", "こんにちは");
        traductor.Add("Adiós", "またね");

        Debug.Log("hola en japonés es -> " + traductor["Hola"]);
    }
}
