using UnityEngine;

public class eventosColliders : MonoBehaviour
{
    void OnCollisionEnter(Collision collision)
    {
        Debug.Log("entró la colisión");
    }

    void OnCollisionStay(Collision collision)
    {
        Debug.Log("Se mantiene en la colisión");
    }

    void OnCollisionExit(Collision collision)
    {
        Debug.Log("Salió de la colisión");
    }
}
