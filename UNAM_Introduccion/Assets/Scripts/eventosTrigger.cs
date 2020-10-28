using UnityEngine;

public class eventosTrigger : MonoBehaviour
{
    void OnTriggerEnter(Collider collision)
    {
        Debug.Log("Trigger entra en contacto");
    }

    void OnTriggerStay(Collider collision)
    {
        Debug.Log("Trigger en contacto");
    }

    void OnTriggerExit(Collider collision)
    {
        Debug.Log("Trigger fuera de contacto");
    }
}


