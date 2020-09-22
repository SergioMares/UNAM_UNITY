using UnityEngine;
using UnityEngine.UI;
public class Mobile : MonoBehaviour
{
    public Text phaseDisplayText;
    private Touch theTouch;
    private float timeTouchEnded;
    private float displayTime = .5f;
    void Update()
    {
        if (Input.touchCount > 0) //cuenta la cantidad de toques en pantalla
        {
            theTouch = Input.GetTouch(0);//el index sera para el número de input en display.
                                         //p.ej. dedo1 dedo2 etc. (0) nos da dedo1           
            phaseDisplayText.text = theTouch.phase.ToString();

            if (theTouch.phase == TouchPhase.Ended)
            {
                timeTouchEnded = Time.time;
            }
        }
        else if (Time.time - timeTouchEnded > displayTime)//cuenta medio segundo antes
                                                          //de desaparecer el texto
        {
            phaseDisplayText.text ="";
        }
    }
}
