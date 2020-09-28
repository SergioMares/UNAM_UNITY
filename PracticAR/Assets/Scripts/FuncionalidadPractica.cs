using UnityEngine;
using Vuforia;
public class FuncionalidadPractica : MonoBehaviour
{
    public float m_ButtonReleaseTimeDelay;
    public float moveSpeed = 0.1f;
    bool avanzar = false; 
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
        //Debug.Log("OnButtonPressed: " + vb.VirtualButtonName);
        avanzar = true;
    }
    //Cuando soltamos el botón pasa...
    public void OnButtonReleased(VirtualButtonBehaviour vb)
    {
        //Debug.Log("OnButtonReleased: " + vb.VirtualButtonName);
        avanzar = false;
    }

    private void Update()
    {
        //Cuando nuestra variable 'avanzar' sea true...
        if (avanzar)
        {
            modelo.transform.Translate(-Vector3.forward * moveSpeed * Time.deltaTime);
        }
        
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