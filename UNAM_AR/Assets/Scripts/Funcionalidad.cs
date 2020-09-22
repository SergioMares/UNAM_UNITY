using UnityEngine;
using Vuforia;
public class Funcionalidad : MonoBehaviour
{
    public float m_ButtonReleaseTimeDelay;
    public GameObject modelo;
    VirtualButtonBehaviour[] virtualButtonBehaviours;
    
    void Awake()
    {
        //registramos en un arreglo los botones 
        virtualButtonBehaviours = GetComponentsInChildren<VirtualButtonBehaviour>();
        for (int i = 0; i < virtualButtonBehaviours.Length; ++i)
        {
            virtualButtonBehaviours[i].RegisterOnButtonPressed(OnButtonPressed);
            virtualButtonBehaviours[i].RegisterOnButtonReleased(OnButtonReleased);
        }
    }

    //cuando apretamos el botón pasa...
    public void OnButtonPressed(VirtualButtonBehaviour vb)
    {
        Debug.Log("OnButtonPressed: " + vb.VirtualButtonName);
        modelo.SetActive(false);
    }
    //Cuando soltamos el botón pasa...
    public void OnButtonReleased(VirtualButtonBehaviour vb)
    {
        Debug.Log("OnButtonReleased: " + vb.VirtualButtonName);
        modelo.SetActive(true);
    }

    public void ObjetivoLocalizado()
    {
        Debug.Log("El objetivo está en campo de visión");
    }

    public void ObjetivoPerdido()
    {
        Debug.Log("El objetivo desapareció del campo de visión");
    }
}
