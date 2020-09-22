using UnityEngine;
using UnityEngine.UI;
public class VirtualDpad : MonoBehaviour
{
    public Text direccionTexto;
    private Touch toque;
    private Vector2 posicionInicial, posicionFinal;
    private string direccion;
    void Update()
    {
        if (Input.touchCount > 0)//verificamos que se esté tocando el screen
        {
            toque = Input.GetTouch(0);//obtenemos info del primer touch en screen

            if (toque.phase == TouchPhase.Began)//guardamos la posición donde inició el toque
            {
                posicionInicial = toque.position;
            }

            //guardamos la posición donde está actualmente el toque o donde haya terminado
            else if (toque.phase == TouchPhase.Moved || toque.phase == TouchPhase.Ended)
            {
                posicionFinal = toque.position;
                float x = posicionFinal.x - posicionInicial.x;//Calculamos la distancia del 
                float y = posicionFinal.y - posicionInicial.y;//punto de partida al actual/final

                if (Mathf.Abs(x) == 0 && Mathf.Abs(y) == 0)//Math.abs devuelve el valor absoluto
                {
                    direccion = "Pulsado";
                }

                //Muestra la dirección del toque con respecto al origen
                else if (Mathf.Abs(x) > Mathf.Abs(y))
                {                    
                    if (x > 0)
                        direccion = "Derecha";
                    else
                        direccion = "Izquierda";                    
                }
                else
                {                    
                    if (y > 0)
                        direccion = "Arriba";
                    else
                        direccion = "Abajo";
                }
            }
        }
        direccionTexto.text = direccion;
    }
}
