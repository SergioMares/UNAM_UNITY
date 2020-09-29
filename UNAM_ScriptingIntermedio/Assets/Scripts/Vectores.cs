using UnityEngine;
public class Vectores : MonoBehaviour
{
    public GameObject go1;
    public GameObject go2;   

    void Update()
    {
        /*
         *La distancia será entre go1 y go2
         *La magnitud es la longitud de go1 al origen (0,0,0)
         *El producto punto devuelve un escalar (número)
         *El producto cruz nos devuelve otro vector
         */
        float dist = Vector3.Distance(go1.transform.position, go2.transform.position);
        float mag = Vector3.Magnitude(go1.transform.position);
        float dot = Vector3.Dot(go1.transform.position, go2.transform.position);
        Vector3 cross = Vector3.Cross(go1.transform.position, go2.transform.position);

        Debug.Log("Distancia = "      + dist + "\n" +
                  "Magnitud (go1) = " + mag + "\n" +
                  "Prod punto = "     + dot + "\n" +
                  "Prod cruz = "      + cross.ToString());

        //Debug.Log("Distancia = " + dist + "\n");
        //Debug.Log("Magnitud (go1) = " + mag + "\n");
        //Debug.Log("Prod punto = " + dot + "\n");
        //Debug.Log("Prod cruz = " + cross.ToString() + "\n");

    }
}
